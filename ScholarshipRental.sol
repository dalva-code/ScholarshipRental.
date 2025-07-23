// License
// SPDX-License-Identifier: LGPL-3.0-only

// Version
pragma solidity 0.8.30;

// Contract
contract ScholarshipRental {

    // Global variables
    address public admin;
    uint public scholarshipAmount;
    uint public durationInMonths;

    // Modifiers
    modifier onlyAdmin() {
        require(msg.sender == admin, "Only admin can call this");
        _;
        
    }

    // Struct to store applicant information
    struct Applicant {
        string name;
        string id;
        address wallet;
        address propertyOwner;
        bool isApproved;
        uint startTime;
    }

    // Mapping to store applicant data by address
    mapping(address => Applicant) public applicants;

    // List of all applicant addresses
    address[] public applicantList;

    // Events for blockchain tracking
    event ApplicationSubmitted(address applicant);
    event ApplicationApproved(address applicant);
    event RentPaid(address to, uint amount, uint timestamp);

    // Constructor - initializes admin and scholarship parameters
    constructor(uint _amount, uint _months) {
        admin = msg.sender;
        scholarshipAmount = _amount;
        durationInMonths = _months;
    }

    // Function to apply for the scholarship
    function applyForScholarship(string memory name_, string memory id_, address propertyOwner_) public {
        // Ensure the user hasn't already applied
        require(applicants[msg.sender].wallet == address(0), "You have already applied");
        require(msg.sender != propertyOwner_, "You cannot be your own landlord");

        // Create new applicant
        applicants[msg.sender] = Applicant({
            name: name_,
            id: id_,
            wallet: msg.sender,
            propertyOwner: propertyOwner_,
            isApproved: false,
            startTime: 0
        });

        // Store applicant's address
        applicantList.push(msg.sender);

        // Emit event
        emit ApplicationSubmitted(msg.sender);
    }

    // Function for the admin to approve a selected applicant
    function approveApplicant(address applicantAddress) public onlyAdmin {
       
       
        // Ensure the applicant exists and hasn't been approved already
        require(applicants[applicantAddress].wallet != address(0), "Applicant not found");
        require(!applicants[applicantAddress].isApproved, "Already approved");

        // Mark as approved and set start time
        applicants[applicantAddress].isApproved = true;
        applicants[applicantAddress].startTime = block.timestamp;

        // Emit event
        emit ApplicationApproved(applicantAddress);
    }

    // Function to simulate monthly rent payment to the property owner
    function simulateMonthlyPayment(address applicantAddress) public onlyAdmin {
        
          // Check if the applicant exists and is approved
          require(applicants[applicantAddress].wallet != address(0), "Applicant not found");
          require(applicants[applicantAddress].isApproved, "Applicant is not approved");

          // Calculate how many months have passed since startTime
          uint elapsedTime = block.timestamp - applicants[applicantAddress].startTime;
          uint monthsPassed = elapsedTime / 30 days;

          // Ensure we are still within the scholarship duration
          require(monthsPassed < durationInMonths, "Scholarship duration has ended");

          // Emit simulated payment to the property owner
         emit RentPaid(
            applicants[applicantAddress].propertyOwner,
            scholarshipAmount / durationInMonths,
            block.timestamp
    );
}

       // View function to check applicant info
    function viewApplicant(address applicantAddress) public view returns (
         string memory name_,
         address wallet_,
         address propertyOwner_,
         bool isApproved_,
         uint startTime_
)  

  {
    require(applicants[applicantAddress].wallet != address(0), "Applicant not found");

    Applicant memory a = applicants[applicantAddress];

    return (
        a.name,
        a.wallet,
        a.propertyOwner,
        a.isApproved,
        a.startTime
    );
}

// Function to cancel a scholarship for a specific applicant
    function cancelScholarship(address applicantAddress) public onlyAdmin {
        // Ensure the applicant exists and is approved
         require(applicants[applicantAddress].wallet != address(0), "Applicant not found");
         require(applicants[applicantAddress].isApproved, "Applicant is not approved");

         // Cancel the scholarship
         applicants[applicantAddress].isApproved = false;
         applicants[applicantAddress].startTime = 0;
}
}



   