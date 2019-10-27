//index of user in account list
var activeIndex = 0;

//address of deployed smart contract
var contractAddress = '0x28d320412ac3cfa35c3d02c41369059afe8a37d9';

//ABI of deployed smart contract
var contractABI = [
	{
		"constant": false,
		"inputs": [
			{
				"name": "requester",
				"type": "string"
			},
			{
				"name": "patientKey",
				"type": "string"
			}
		],
		"name": "isAuthorized",
		"outputs": [
			{
				"name": "",
				"type": "bool"
			}
		],
		"payable": false,
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"constant": false,
		"inputs": [],
		"name": "getUserType",
		"outputs": [
			{
				"name": "",
				"type": "int256"
			}
		],
		"payable": false,
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"constant": false,
		"inputs": [],
		"name": "checkNextRegistry",
		"outputs": [],
		"payable": false,
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"constant": false,
		"inputs": [
			{
				"name": "user",
				"type": "string"
			},
			{
				"name": "patientKey",
				"type": "string"
			},
			{
				"name": "recordIndex",
				"type": "uint256"
			}
		],
		"name": "getThisHealthRecord",
		"outputs": [
			{
				"name": "",
				"type": "string"
			}
		],
		"payable": false,
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"constant": false,
		"inputs": [
			{
				"name": "addrString",
				"type": "string"
			}
		],
		"name": "registerPatient",
		"outputs": [],
		"payable": false,
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"constant": false,
		"inputs": [
			{
				"name": "user",
				"type": "string"
			},
			{
				"name": "providerKey",
				"type": "string"
			}
		],
		"name": "authorizeProvider",
		"outputs": [],
		"payable": false,
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"constant": false,
		"inputs": [
			{
				"name": "addrString",
				"type": "string"
			}
		],
		"name": "registerProvider",
		"outputs": [],
		"payable": false,
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"constant": false,
		"inputs": [
			{
				"name": "user",
				"type": "string"
			},
			{
				"name": "patientKey",
				"type": "string"
			},
			{
				"name": "phi",
				"type": "string"
			}
		],
		"name": "addHealthRecord",
		"outputs": [],
		"payable": false,
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"anonymous": false,
		"inputs": [
			{
				"indexed": false,
				"name": "returnValue",
				"type": "bool"
			}
		],
		"name": "checkRegistry",
		"type": "event"
	},
	{
		"anonymous": false,
		"inputs": [
			{
				"indexed": false,
				"name": "uType",
				"type": "int256"
			}
		],
		"name": "userType",
		"type": "event"
	},
	{
		"anonymous": false,
		"inputs": [
			{
				"indexed": false,
				"name": "data",
				"type": "string"
			}
		],
		"name": "getRecord",
		"type": "event"
	},
	{
		"anonymous": false,
		"inputs": [
			{
				"indexed": false,
				"name": "access",
				"type": "string"
			}
		],
		"name": "checkAccess",
		"type": "event"
	}
];