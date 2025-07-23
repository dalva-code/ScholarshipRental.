🏠 Scholarship Rental – Decentralized Housing Grant System

📝 Overview

ScholarshipRental is a smart contract built in Solidity that simulates a decentralized system for managing rental scholarships (housing grants). It allows an admin (e.g., an NGO, institution, or government) to approve applicants and simulate monthly scholarship payments directly to property owners.

This system ensures:
	•	✅ Only the admin can approve or cancel grants.
	•	🧑‍💻 Applicants can apply by specifying their identity and their landlord.
	•	🏡 Property owners receive the monthly simulated payments.
	•	🔐 Self-dealing is prevented (applicants cannot list themselves as landlords).

⸻

✨ Features
	1.	👤 One-Time Application
Applicants can only apply once and must provide valid identity and landlord data.
	2.	🔐 Admin-Only Approval & Management
Only the admin (contract deployer) can:
	•	Approve applicants
	•	Simulate rent payments
	•	Cancel scholarships
	3.	📆 Simulated Monthly Payments
Calculates how much time has passed since approval and emits an event for monthly rent.
	4.	❌ Scholarship Cancellation
Admin can cancel a grant at any time, resetting applicant’s state.
	5.	📡 Event Logging for Transparency
All actions emit events for blockchain tracking: application, approval, rent payment.

📖 Contract Summary

| 🔧 Function Name                | 📋 Description                                                                 |
|-------------------------------|--------------------------------------------------------------------------------|
| applyForScholarship(...)      | Allows a user to apply by submitting their name, ID, and landlord address.     |
| approveApplicant(address)     | Admin-only: Approves an applicant and starts the scholarship period.           |
| simulateMonthlyPayment(...)   | Admin-only: Emits a simulated rent payment to the landlord if still valid.     |
| cancelScholarship(address)    | Admin-only: Cancels the grant for a given applicant.                           |
| viewApplicant(address)        | Returns all stored data for an applicant.                                      |


⚙️ Prerequisites

Tools Required:
	•	🧪 Remix IDE
	•	🧱 Solidity Compiler v0.8.30

⸻

🚀 How to Deploy & Use

1️⃣ Deploy the Contract
	1.	Open Remix IDE
	2.	Create a new file called ScholarshipRental.sol
	3.	Paste the contract code
	4.	Go to Solidity Compiler tab:
	•	Select version 0.8.30
	•	Click ✅ Compile ScholarshipRental.sol
	5.	Go to Deploy & Run Transactions tab:
	•	Select environment Remix VM (Cancun)
	•	Enter scholarship amount (e.g., 1200) and duration in months (e.g., 6)
	•	Click 🚀 Deploy

⸻

2️⃣ Test Workflow

👤 A. Apply for Scholarship
	1.	Switch to a different account (not the admin).
	2.	Use the function applyForScholarship with:
	•	name: "David"
	•	id: "ID1234"
	•	propertyOwner: Address of landlord (another account, not yourself!)

✅ B. Approve Applicant
	1.	Switch back to the admin account
	2.	Call approveApplicant(address) with the applicant’s address.

💰 C. Simulate Rent Payment
	1.	Still as admin, call simulateMonthlyPayment(address)
	2.	Will emit a RentPaid event with amount and timestamp if scholarship is still active.

🛑 D. Cancel Scholarship
	1.	Admin can call cancelScholarship(address)
	2.	Applicant will be marked as isApproved = false and startTime = 0.

🔍 E. View Applicant Data
	•	Use viewApplicant(address) to inspect:
	•	Name, wallet, property owner, approval status, and start time.

⸻

📂 Code Architecture Highlights
	•	🔒 onlyAdmin modifier ensures restricted access to key functions.
	•	📦 Applicant struct holds detailed applicant data.
	•	🧠 mapping stores all applicants by address.
	•	📡 Events: All key actions emit logs for auditability.

⸻

💡 Potential Improvements
	1.	💸 Real Token Transfers (e.g., USDC or ETH)
	2.	🧾 Upload identity docs via IPFS
	3.	📊 Dashboard with front-end integration (React or Next.js)
	4.	⏳ Auto-expiration for scholarships
	5.	📈 Public analytics for transparency

⸻

📜 License

This project is licensed under the LGPL-3.0-only license. See the LICENSE file for more information.