# Text-Based Entities Support

This update allows the DOJ MDT system to handle both citizen IDs and text-based entities (like companies/businesses) in reports.

## How It Works

### Database Structure
- No database changes are required
- The existing `accused` and `suing` fields in `doj_reports` table can store both citizen IDs and text
- Citizen IDs are typically alphanumeric strings (8-20 characters)
- Text-based entities can be any string (company names, business names, etc.)

### Functionality

#### 1. Entity Detection
The system uses the `Editable.isCitizenId()` function to determine if an identifier is:
- **Citizen ID**: Alphanumeric string that exists in the players table
- **Text-based entity**: Any other string (company names, business names, etc.)

#### 2. Search Integration
When searching for citizens in the MDT:
- Searches both citizens and companies
- Companies are pulled from:
  - `doj_companies` table
  - `p_bank_accounts` (society accounts)
  - `crm_bank_accounts` (society accounts)

#### 3. Display Names
- Citizen IDs: Display as "Firstname Lastname"
- Text-based entities: Display as the text itself (e.g., "LSPD", "BCSO")

#### 4. Court Hearings
- **Citizen IDs**: Can receive phone notifications and be jailed if convicted
- **Text-based entities**: Cannot be jailed but can be fined or have other consequences

## Usage Examples

### Creating Reports
1. When creating a report, you can now select either:
   - A citizen (by searching their name)
   - A company/business (by searching the company name)

2. The system will automatically detect the type and handle it appropriately

### Court Hearings
- If a citizen is convicted, they can be jailed normally
- If a company is convicted, they cannot be jailed but other consequences can be applied

## Technical Details

### Key Functions
- `Editable.isCitizenId(identifier)`: Determines if an identifier is a citizen ID
- `Bridge.getEntityDisplayName(identifier)`: Gets the display name for any entity type
- `Bridge.searchCompanies(value)`: Searches for companies in various tables

### Supported Company Sources
1. **doj_companies** table - Main companies list
2. **p_bank_accounts** - Society accounts (if p_banking is active)
3. **crm_bank_accounts** - Society accounts (if crm-banking is active)

## No Database Changes Required
The existing database structure supports this functionality without any modifications. The `accused` and `suing` fields are already `varchar(46)` which can accommodate both citizen IDs and text-based entities. 