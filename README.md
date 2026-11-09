
# AZ-305: Two-Stage Secure Landing Zone with Terraform

This project provisions a secure, enterprise-grade Hub-and-Spoke architecture on Microsoft Azure using Terraform. It follows the architectural requirements for the **AZ-305: Designing Microsoft Azure Infrastructure Solutions** exam, demonstrating network isolation, zero-trust secrets management, split-horizon private DNS, and infrastructure lifecycle decoupling.

---

## Architecture Diagram

```text
============================== STAGE 1: BOOTSTRAP ==============================
  [ Local State ] ──▶  Azure Resource Group: rg-az305tf-state-<location>
                             └── Storage Account: az305tfstate<suffix>
                                       └── Blob Container: tfstate
                                                 └── workload.hubspoke.tfstate (Lease Lock)

============================== STAGE 2: WORKLOAD ===============================
                                     +----------------------------------------+
                                     |         Hub VNet (10.0.0.0/16)         |
                                     |                                        |
                                     |   +--------------------------------+   |
                                     |   | Subnet: snet-hub-shared        |   |
                                     |   | (10.0.1.0/24)                  |   |
                                     |   | - Azure Key Vault              |   |
                                     |   |   (Azure RBAC Authorized)      |   |
                                     |   +--------------------------------+   |
                                     +-------------------+--------------------+
                                                         |
                                         Bi-Directional VNet Peering
                                                         |
                                     +-------------------+--------------------+
                                     |        Spoke VNet (10.1.0.0/16)        |
                                     |                                        |
                                     |   +--------------------------------+   |
                                     |   | Subnet: snet-spoke-app         |   |
                                     |   | (10.1.1.0/24 - Delegated)      |   |
                                     |   | - Linux App Service (B1)       |   |
                                     |   |   - Managed Identity (System)  |   |
                                     |   |   - WEBSITE_VNET_ROUTE_ALL = 1 |   |
                                     |   +---------------+----------------+   |
                                     |                   |                    |
                                     |       Regional VNet Integration        |
                                     |                   |                    |
                                     |   +---------------v----------------+   |
                                     |   | Subnet: snet-spoke-pe          |   |
                                     |   | (10.1.2.0/24)                  |   |
                                     |   | - Private Endpoint (SQL NIC)   |   |
                                     |   +---------------+----------------+   |
                                     +-------------------|--------------------+
                                                         |
                                             Private Link Service Connection
                                                         |
                                     +-------------------v--------------------+
                                     |         Azure SQL Database             |
                                     | - Public Network Access: Disabled      |
                                     | - Private DNS: privatelink.database... |
                                     +----------------------------------------+
```
