# Double-blockchain-implementation-section

The blockchain platform built on the Ubuntu 22.04.1 system is fiscobcos version 2.0, on which two blockchains are constructed: group1 and group2. Group1 is a public blockchain, while group2 is a local blockchain. The consensus algorithm used is the PBFT algorithm provided by the platform. Additionally, the WeCross v1.3.0 cross-chain platform is employed to deploy smart contracts on the blockchain and facilitate interactions between blockchains. The public blockchain is responsible for generating and storing multiple hash chains within the local domain, as well as querying the node information on the stored hash chains. The local blockchain generates a local hash chain based on the registration status of new devices and queries the node information on the chain. 
The Hash Chain Contract (HC) and Hash Chain System 3 Contract (HCS3) play a crucial role in the blockchain, enhancing the system’s efficiency and reliability through automation, transparency, data security, and reduced trust costs. The HC is responsible for the automatic execution of transactions, ensuring the integrity and traceability of the data, while the HCS3 introduces digital certificates, enhancing security and the trust mechanism, and supports multi-region chain generation, making it suitable for complex multi-party collaboration scenarios. Smart contracts not only transform the execution of traditional transactions but also provide a powerful trust mechanism and security for decentralized systems.
The specific blockchain implementation flowchart is shown below:

<img width="665" alt="image" src="https://github.com/user-attachments/assets/834eac05-e00a-4500-a13a-fe9c8c2c9a9f" />


