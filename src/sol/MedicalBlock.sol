pragma solidity ^0.5.1;

/*
* This smart contract defines a list of patient and provider users.
* Patients have a list of medical records, while providers have a list
* of patient keys that they can use to access or add medical records
* about a certain patient. Users must first be registered with the
* register functions to be active in the system. A patient must
* authorize a provider with the authroizeProvider function before a
* provider can access or add medical records for a patient.
*/
contract MedicalBlock {
    
    /*
    * A patient has a key and an array of health records.
    * Their number of health records is stored.
    */
    struct Patient {
        address key;
        string[] records;
        uint numRecords;
        bool exists;
    }
    
    /*
    * A provider has a key and an array of patient keys.
    * Their number of patient keys is stored.
    */
    struct Provider {
        address key;
        address[] patientKeys;
        uint numKeys;
        bool exists;
    }
    
    mapping (address => Patient) patients;
    mapping (address => Provider) providers;
    mapping (string => address) userAddresses;
    
    event checkRegistry(bool returnValue);
    event userType(int uType);
    event getRecord(string data);
    event checkAccess(string access);
    
    /*
    * This function determines if the user at the sending address
    * is registered in the system. It returns true if they are registered
    * or false if they are not registered.
    */
    function checkNextRegistry() public {
        if (patients[msg.sender].exists)
        {
            emit checkRegistry(true);
            return;
        }
        if (providers[msg.sender].exists)
        {
            emit checkRegistry(true);
            return;
        }
        else
            emit checkRegistry(false);
        return;
    }
    
    /*
    * This function registers a new patient by storing their address as their public key.
    *
    * Parameters: addrString (IN) The address of the new patient in string form
    */
    function registerPatient(string memory addrString) public {
        if (patients[msg.sender].exists || providers[msg.sender].exists)
            return;
        else
        {
            patients[msg.sender].key = msg.sender;
            patients[msg.sender].exists = true;
            patients[msg.sender].numRecords = 0;
            userAddresses[addrString] = msg.sender;
            return;
        }
    }
    
    /*
    * This function registers a new provider by storing their address as their public key.
    *
    * Parameters: addrString (IN) The address of the new provider in string form
    */
    function registerProvider(string memory addrString) public {
        if (patients[msg.sender].exists || providers[msg.sender].exists)
            return;
        
        else
        {
            providers[msg.sender].key = msg.sender;
            providers[msg.sender].exists = true;
            providers[msg.sender].numKeys = 0;
            userAddresses[addrString] = msg.sender;
            return;
        }
    }
    
    /*
    * This function is used to determine if a user is a patient or provider based on their address.
    *
    * Returns: 1 if the user is a patient,
    *          2 if the user is a provider,
    *          0 if the user is not found
    */
    function getUserType() public returns (int) {
        if (patients[msg.sender].exists)
        {
            emit userType(1);
            return 1;
        }
        if (providers[msg.sender].exists)
        {
            emit userType(2);
            return 2;
        }
        emit userType(0);
        return 0;
    }
    
    /*
    * This function is used to add a health record to a patient's list of records. The sending
    * user must be the associated patient or an authorized provider.
    *
    * Parameters: user (IN) The sending address of the user in string form
    *             patientKey (IN) The associated patient's key in string form
    *             phi (IN) the protected health information that defines the record
    */
    function addHealthRecord(string memory user, string memory patientKey, string memory phi) public {
        bool authorized = isAuthorized(user, patientKey);
        if (authorized)
        {
            address pAddr = userAddresses[patientKey];
            patients[pAddr].records.push(phi);
            patients[pAddr].numRecords++;
        }
    }
    
    /*
    * This function is called by patients to give providers authorized access to
    * add and view their health records.
    *
    * Parameters: user (IN) The sending address of the user in string form
    *             providerKey (IN) The key belonging to the provider to authorize
    */
    function authorizeProvider(string memory user, string memory providerKey) public {
        address uAddr = userAddresses[user];
        address pAddr = userAddresses[providerKey];
        require(!(providers[uAddr].exists), "Error: Only Patients can Authorize Providers");
        providers[pAddr].patientKeys.push(uAddr);
        providers[pAddr].numKeys++;
    }
    
    /*
    * This function checks if a user is authorized to interact with a patient key.
    *
    * Parameters: requester (IN) The address of the user wishing to interact with the
    *                            patient account.
    *             patientKey (IN) the key belonging to the patient account
    *
    * Returns: true if the requesting user is authorized to interact with the
    *              patient account
    */
    function isAuthorized(string memory requester, string memory patientKey) public returns(bool) {
        address rAddr = userAddresses[requester];
        address pAddr = userAddresses[patientKey];
        if (patients[rAddr].exists)
        {
            if (!(rAddr == msg.sender))
            {
                emit checkAccess("WrongPatient");
                return false;
            }
            else
            {
                emit checkAccess("true");
                return true;
            }
        }
        else
        {
            for (uint i = 0; i < providers[rAddr].numKeys; i++)
            {
                if (providers[rAddr].patientKeys[i] == pAddr)
                {
                    emit checkAccess("true");
                    return true;
                }
            }   
            emit checkAccess("NoProviderAccess");
            return false;
        }
    }

    /*
    * This function gets a health record from a patient account only if
    * the active user is authorized to do so.
    *
    * Parameters: user (IN) The sending address of the user in string form
    *             patientKey (IN) The key belonging to the patient account to access
    *                             health records from
    *             recordIndex (IN) The index in the list of the requested health record
    *
    * Returns: protected health information of the record if the index is valid,
               error message if the index is invalid
    */
    function getThisHealthRecord(string memory user, string memory patientKey, uint recordIndex) public
        returns (string memory)
    {
        bool authorized = isAuthorized(user, patientKey);
        if (authorized)
        {
            address pAddr = userAddresses[patientKey];
            if (recordIndex >= 0 && recordIndex < patients[pAddr].numRecords)
            {
                emit getRecord(patients[pAddr].records[recordIndex]);
                return string(patients[pAddr].records[recordIndex]);
            }
            else
            {
                emit getRecord("Invalid");
                return "Invalid Record Index Specified";
            }
        }
    }
    
}
