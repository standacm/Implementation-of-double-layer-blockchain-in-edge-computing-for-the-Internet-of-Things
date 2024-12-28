// SPDX-License-Identifier: MIT  
pragma solidity >=0.4.24 <0.6.0;
pragma experimental ABIEncoderV2;

contract AttributeRevocationList {

    // 撤销证书结构体
    struct RevocationCertificate {
        uint256 id;                  // 证书唯一标识符
        string reason;               // 撤销原因
        uint256 timestamp;           // 撤销时间戳
        uint256 expirationTimestamp; // 证书有效期结束时间戳
        bool isRevoked;              // 证书是否被撤销的状态
    }

    // 存储所有撤销证书的映射
    mapping(uint256 => RevocationCertificate) private revocationCertificates;
    // 用于追踪证书数量
    uint256 public certificateCount;

    // 事件用于记录新的撤销证书被添加
    event CertificateRevoked(uint256 indexed id, string reason, uint256 timestamp);

    // 函数用于添加新的撤销证书
    function addRevocationCertificate(uint256 _id, string memory _reason, uint256 _expirationTimestamp) public returns(bool) {
        require(revocationCertificates[_id].timestamp == 0, "Certificate ID already exists");

        // 创建新的撤销证书并将其加入映射中
        revocationCertificates[_id] = RevocationCertificate(_id, _reason, block.timestamp, _expirationTimestamp, false);
        certificateCount++;

        // 触发事件
        emit CertificateRevoked(_id, _reason, block.timestamp);

        return true;
    }

    // 函数用于检查证书是否被撤销
    function checkIfRevoked(uint256 _id) public returns (bool) {
        RevocationCertificate storage cert = revocationCertificates[_id];

        if (cert.timestamp == 0) {
            return false; // 证书不存在
        }

        // 自动撤销过期证书
        if (block.timestamp > cert.expirationTimestamp && !cert.isRevoked) {
            cert.isRevoked = true;  // 自动撤销
            emit CertificateRevoked(_id, "Expired certificate automatically revoked", block.timestamp);
        }

        // 如果证书的有效期已经过期或者证书状态已经被标记为撤销，则认为证书已被撤销
        return cert.isRevoked;
    }

    // 函数用于手动设置证书为撤销状态
    function revokeCertificate(uint256 _id) public returns(bool) {
        require(revocationCertificates[_id].timestamp != 0, "Certificate does not exist");
        
        revocationCertificates[_id].isRevoked = true;
        emit CertificateRevoked(_id, "Manually revoked", block.timestamp);
        return true;
    }

    // 函数用于获取指定ID的撤销证书信息
    function getRevocationCertificate(uint256 _id) public view returns (uint256, string memory, uint256, uint256, bool) {
        RevocationCertificate storage cert = revocationCertificates[_id];
        return (cert.id, cert.reason, cert.timestamp, cert.expirationTimestamp, cert.isRevoked);
    }

    // 函数用于获取证书总数
    function getCertificateCount() public view returns (uint256) {
        return certificateCount;
    }
}
