# MedicalBlock
  Medical Block is a prototype blockchain electronic health record (EHR) framework. It was used to record and analyze the costs of adding
data directly to the ethereum blockchain. In this system, a Solidity smart contract is deployed to an ethereum blockchain network,
which can be local or the main network. A front-end web application is then connected to the deployed smart contract using
the smart contract's address and ABI. After the two are connected, users with a blockchain address can interact with the system.
  Users may be one of two types: patient or provider. Patients can add and view their own health records. Providers can do the same
for patients that have authorized them to do so. Providers are authorized by patients by giving the provider their public key,
which, in this system, is simply their address on the blockchain. This way, the system utilizes access control techniques made possible
with Solidity to restrict accessing health records to only the owning patient or an authorized provider.
  This program was written by Ross Baldwin during the summer of 2019 as part of the Summer Undergraduate Scholars program at the
University of Wisconsin-Platteville.
