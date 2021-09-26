// SPDX-License-Identifier: MIT
pragma solidity >=0.4.21 <=0.8.7;

contract Certification {
    constructor() public {}

    struct Certificate {
        string studentName;
        string issuerName;
        string issuerCode;
        string courseName;
        uint256 issueDate;
        string email;
        bool isEnabled;
    }

    mapping(bytes32 => Certificate) public certificates;
    event certificateGenerated(bytes32 _certificateId);

    function stringToBytes32(string memory source)
        private
        pure
        returns (bytes32 result)
    {
        bytes memory tempEmptyStringTest = bytes(source);
        if (tempEmptyStringTest.length == 0) {
            return 0x0;
        }
        assembly {
            result := mload(add(source, 32))
        }
    }

    function generateCertificate(
        string memory _id,
        string memory _studentName,
        string memory _issuerName,
        string memory _issuerCode,
        string memory _courseName,
        string memory _email,
        uint256 _issueDate,
        bool _isEnabled
    ) public {
        bytes32 byte_id = stringToBytes32(_id);
        certificates[byte_id] = Certificate(
            _studentName,
            _issuerName,
            _issuerCode,
            _courseName,
            _issueDate,
            _email,
            _isEnabled
        );
        emit certificateGenerated(byte_id);
    }

    function getCertificateById(string memory _id)
        public
        view
        returns (Certificate memory)
    {
        bytes32 byte_id = stringToBytes32(_id);
        return certificates[byte_id];
    }
}
