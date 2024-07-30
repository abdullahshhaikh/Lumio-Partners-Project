# Lumio Partners Project

This project outlines the steps to create a custom field on the Order object and deploy it to your Salesforce Developer Edition Org using Visual Studio Code and Salesforce CLI.

## Steps to Set Up the Project

1. **Create a Custom Field**  
   Add a new custom field on the Order object:
   - **Field Name:** `Total_Quantity__c`
   - **Field Type:** (specify the type, e.g., Number, Formula, etc.)

2. **Set Up Your Project**  
   Create a new standard Salesforce project in Visual Studio Code:
   - Ensure you have the Salesforce Extension Pack and Salesforce CLI installed.
   - Use the command palette (Ctrl + Shift + P) and select `SFDX: Create Project`.

3. **Authorize Your Salesforce Org**  
   Connect your project to your Developer Edition Org:
   - In Visual Studio Code, open the command palette and select `SFDX: Authorize an Org`.
   - Follow the prompts to log in to your Salesforce Developer Edition Org.

4. **Update the `package.xml` File**  
   Add the contents of the provided `package.xml` file to your project's `package.xml` file. This file defines the components you will deploy.

5. **Deploy the Source to Your Org**  
   Deploy the components to your Salesforce Org:
   - Right-click the `package.xml` file in your project folder.
   - Select `SFDX: Deploy Source in Manifest to Org`.

6. **Verify Deployment**  
   After deployment, navigate to your Salesforce Org to verify that all components have been successfully deployed.

## Conclusion

You should now have a new custom field on the Order object in your Salesforce Org. If you encounter any issues during 
