package com.aml.utilities;

import static java.time.format.DateTimeFormatter.ofPattern;
import static java.util.Arrays.asList;
import static net.andreinc.mockneat.unit.address.Cities.cities;
import static net.andreinc.mockneat.unit.address.USStates.usStates;
import static net.andreinc.mockneat.unit.objects.From.fromStrings;
import static net.andreinc.mockneat.unit.text.CSVs.csvs;
import static net.andreinc.mockneat.unit.time.LocalDates.localDates;
import static net.andreinc.mockneat.unit.types.Ints.ints;
import static net.andreinc.mockneat.unit.user.Emails.emails;
import static net.andreinc.mockneat.unit.user.Names.names;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;

import net.andreinc.mockneat.MockNeat;

//import org.junit.Test;

/*
@Author 
owais Jilani
28-June-21  */

public class CSVGenerator{

		public static List<String> cashDirections = asList("CashBoth", "CashIn", "CashOut");
		public static List<String> transactionType = asList("ACCOUNT_MAINTENANCE", "ACH","ADJUSTMENT", "CASH",
				"CHECK_CASH", "CREDIT_CARD", "CURRENCY_EXCHANGE", "DEBIT_CARD", "DIVIDENDS", "FEE", "HOLD", "INTERNAL_TRANSFER",
				"LOAN_ADVANCE", "LOAN_CREDIT", "LOAN_DEFAULT", "MISC_CREDIT", "MISC_DEPOSIT", "MISC_WITHDRAWAL", "MONETARY_INSTRUMENT",
				"NEW_ACCOUNT", "NEW_LOAN", "OTHER", "PAYMENT","REDEMPTION", "REVERSAL", "WIRE", "WITHHOLDINGS");
		public static List<Integer> channels = asList(1, 2, 3, 4, 5, 6, 7, 8, 9, 27);
		public static Integer BATCH_SIZE = 10000;
		public static DateTimeFormatter formatter = ofPattern("yyyy-MM-dd");
		public static List<Integer> type = asList(2, 3);
		public static List<String> gender = asList("MALE", "FEMALE");
		public static List<String> employer = asList("BANK_A", "BANK_B");
		public static List<String> occupation = asList("Medical Scientist", "Mechanical Engineer");
		public static List<String> proof = asList("Passport", "Birth Certificate");
		public static List<String> maritalStatus = asList("NEVER_MARRIED", "MARRIED", "SEPARATED","DIVORCED","WIDOWED","OTHER");
		public static List<String> countryCode = asList("US", "CA", "IN","CU","PK");
		public static final String DATE_TIME_FORMAT = "yyyy-MM-dd HH:mm:ss";
		public static final DateTimeFormatter dateTimeFormatter = ofPattern(DATE_TIME_FORMAT);
	    public static List<String> multipleCountryCode = asList("US", "CA", "IN", "IR;IN", "US;CA;IR");
		public static List<Integer> OFACEntities_type = asList(2);
	    public static List<String>  booleanValues = asList("TRUE", "FALSE");
	    private static List<String> channelOfAccountOpening = asList("BRANCH","ONLINE","BRANCH;ONLINE");
	    private static List<String> serviceType = asList("MONEY TRANSFER","ONLINE BANKING","CHECKING;MONEY TRANSFER","CHECKING;MONEY TRANSFER;ONLINE BANKING");
	    private static List<String> collateralType = asList("BONDS","MIXED USE","STOCKS","STOCKS;BONDS;MIXED USE");
	    private static List<String> naicsCode = asList("721","5412", "5523","5313","7131");
	    private static List<String> businessType = asList("EMBASSY AND CONSULATE","MONEY SERVICES BUSINESSES","NOT PROVIDED","JEWELERS");
	    private static List<String> clientSegement = asList("Commercial", "Top Core","Private Banking","Wealth Management");
	    private static List<String> relationshipType = asList("BENEFICIAL_OWNER", "CONTROLLING_PARTY");
	    private static List<String> ownershipStatus = asList("ACTIVE", "INACTIVE");
	    private static List<String> identificationDocumentType = asList("PASSPORT", "DRIVING LICENSE","OTHER");
	    private static List<String> phoneType = asList("HOME", "WORK");
	    private static List<String> transactionOperation = asList("CREDIT", "DEBIT"); 
	    public static String folderPath = System.getProperty("user.dir");
	    private static MockNeat m = MockNeat.threadLocal();
	    
		static public void  generateAllCSVs(int noOfRecords,int individualStartRange,int individualAccStartRange,int businessStartRange,int businessAccStartRange) {	         
			createIndividualCSV(noOfRecords,individualStartRange);
			createBusinessCSV(noOfRecords,businessStartRange);
			createAccountsCSV(noOfRecords,individualAccStartRange,businessAccStartRange);
			createAccountRelationshipCSV(noOfRecords,individualStartRange,individualAccStartRange,businessStartRange,businessAccStartRange);
			createIndividualBusinessRelationshipCSV(noOfRecords,individualStartRange,businessStartRange);
			createAddressCSV(noOfRecords,individualStartRange,businessStartRange);
			createEMAILAddressCSV(noOfRecords,individualStartRange,businessStartRange);
			createIdentificationDocumentCSV(noOfRecords,individualStartRange,businessStartRange);
			createPhoneCSV(noOfRecords,individualStartRange,businessStartRange);
			createTransactionCSV(noOfRecords,individualAccStartRange,businessAccStartRange);
		
		}
	    
		static private void createIndividualCSV(int noOfRecords,int individualStartRange) {
			
			// Headers
			csvs()
	        .column("INDIVIDUAL_ID")
	        .column("IS_CUSTOMER")
	        .column("CUSTOMER_SINCE")
	        .column("CLOSE_DATE")
	        .column("FIRST_NAME")
	        .column("MIDDLE_NAME")
	        .column("LAST_NAME")
	        .column("NAME_SUFFIX")
	        .column("ALTERNATE_NAMES")
	        .column("GENDER")
	        .column("EMPLOYER")
	        .column("INTERNAL_EMPLOYEE")
	        .column("OCCUPATION")
	        .column("MARITAL_STATUS")
	        .column("GROSS_ANNUAL_INCOME")
	        .column("NATIONALITY")
	        .column("BIRTH_DATE")
	        .column("TIN_TYPE")
	        .column("TIN")
	        .column("EXEMPT_CDD")
	        .column("EXEMPT_SANCTIONS")
	        .column("RESIDENCY")
	        .column("TRANSACTIONAL_COUNTRIES")
	        .column("PEP")
	        .column("SUBPOENA")
	        .column("314B")
	        .column("NEGATIVE_NEWS")
	        .column("OFAC")
	        .column("CHANNEL_OF_ACCOUNT_OPENING")
	        .column("SERVICE_TYPE")
	        .column("CLIENT_SEGMENT")
	        .column("COLLATERAL_TYPE")
	        .column("COMMENTS")
	        .write("DataIntakeInput/INDIVIDUAL_.csv", 1, false);
			
			csvs()
	        .column(m.intSeq().start(individualStartRange).increment(1))
	        .column(fromStrings(booleanValues))
	        .column("2000-10-17 12:31:26")
	        .column("")
	        .column(names().first())
	        .column(names().first())
	        .column(names().last())
	        .column("")
	        .column("")
	        .column(fromStrings(gender))
	        .column(fromStrings(employer))
	        .column(fromStrings(booleanValues))
	        .column(fromStrings(occupation))
	        .column(fromStrings(maritalStatus))
	        .column("")
	        .column(fromStrings(countryCode))
	        .column("2000-10-17 12:31:26")
	        .column("EIN")
	        .column(ints().rangeClosed(100000000,200888999))
	        .column(fromStrings(booleanValues))
	        .column(fromStrings(booleanValues))
	        .column(fromStrings(countryCode))
	        .column(fromStrings(multipleCountryCode)) //TrCountries
	        .column(fromStrings(booleanValues))
	        .column(fromStrings(booleanValues))
	        .column(fromStrings(booleanValues))
	        .column(fromStrings(booleanValues))
	        .column(fromStrings(booleanValues))
	        .column(fromStrings(channelOfAccountOpening))
	        .column(fromStrings(serviceType))
	        .column(fromStrings(clientSegement))
	        .column(fromStrings(collateralType))
	        .column("Valid")
	        .write("DataIntakeInput/INDIVIDUAL_.csv", noOfRecords, true);
			System.out.format("\nIndividual CSV File Generated Successfully...");	  			
		}
		
		static private void createBusinessCSV(int noOfRecords,int businessStartRange) {
		        //Headers
		        csvs()
		            .column("BUSINESS_ID")
		            .column("IS_CUSTOMER")
		            .column("CUSTOMER_SINCE")
		            .column("CLOSE_DATE")
		            .column("NAME")
		            .column("DBA_NAME")
		            .column("INDUSTRY_CODE_TYPE")
		            .column("INDUSTRY_CODE")
		            .column("FORMATION_DATE")
		            .column("FORMATION_COUNTRY")
		            .column("WEBSITE_URL")
		            .column("TIN_TYPE")
		            .column("TIN")
		            .column("EXEMPT_CDD")
		            .column("EXEMPT_SANCTIONS")
		            .column("OPERATION_COUNTRY")
		            .column("BUSINESS TYPE")
		            .column("TRANSACTIONAL_COUNTRIES")
		            .column("SUBPOENA")
		            .column("314B")
		            .column("NEGATIVE_NEWS")
		            .column("OFAC")
		            .column("CHANNEL_OF_ACCOUNT_OPENING")
		            .column("SERVICE_TYPE")
		            .column("CLIENT_SEGMENT")
		            .column("COLLATERAL_TYPE")
		            .column("COMMENTS")
		            .write("DataIntakeInput/BUSINESS_.csv", 1, false);
		        csvs()
		            .column(m.intSeq().start(businessStartRange).increment(1))
		            .column(fromStrings(booleanValues))
		            .column("2000-10-17 12:31:26")
		            .column("")//cld
		            .column(names().last())
		            .column(names().first())
		            .column("NAICS")
		            .column(fromStrings(naicsCode))
		            .column("2000-10-17 12:31:26")
		            .column(fromStrings(countryCode))
		            .column("www.website.com")
		            .column("EIN")
		            .column(ints().rangeClosed(300000000, 400888999))
		            .column(fromStrings(booleanValues))
		            .column(fromStrings(booleanValues))
		            .column(fromStrings(multipleCountryCode)) //OprCon
		            .column(fromStrings(businessType))
		            .column(fromStrings(multipleCountryCode))
		            .column(fromStrings(booleanValues))
		            .column(fromStrings(booleanValues))
		            .column(fromStrings(booleanValues))
		            .column(fromStrings(booleanValues))
		            .column(fromStrings(channelOfAccountOpening))
		            .column(fromStrings(serviceType))
		            .column(fromStrings(clientSegement))
		            .column(fromStrings(collateralType))
		            .column("Valid")
		            .write("DataIntakeInput/BUSINESS_.csv", noOfRecords, true);
				System.out.format("\nBusiness CSV File Generated Successfully...");	 

		    }	
	
		static private void createAccountsCSV(int noOfRecords,int individualAccStartRange,int businessAccStartRange) {
	        csvs()
	            .column("NUMBER")
	            .column("TYPE")
	            .column("PRODUCT_NAME")
	            .column("STATUS")
	            .column("OPEN_DATE")
	            .column("CLOSE_DATE")
	            .column("REOPEN_DATE")
	            .column("INITIAL_BALANCE")
	            .column("CURRENT_BALANCE")
	            .column("BRANCH_ID")
	            .column("LOAN_RELEASE_DATE")
	            .column("LOAN_AMOUNT")
	            .column("LOAN_INSTALLMENT_AMOUNT")
	            .column("LOAN_MATURITY_DATE")
	            .column("COMMENTS")
	            .write("DataIntakeInput/ACCOUNT_.csv", 1, false);

	        csvs()
	            .column(m.intSeq().start(individualAccStartRange).increment(1))
	            .column("LOAN")
	            .column("Loan")
	            .column("ACTIVE")
	            .column(localDates().between(LocalDate.of(2010, 12, 25), LocalDate.of(2020, 12, 25)))
	            .column("")
	            .column("")
	            .column(ints().rangeClosed( 10000, 20000))
	            .column(ints().rangeClosed( 10000, 20000))
	            .column("branch")
	            .column(localDates().between(LocalDate.of(2010, 12, 25), LocalDate.of(2020, 12, 25)))
	            .column(ints().rangeClosed( 10000, 20000))
	            .column(ints().rangeClosed( 10000, 20000))
	            .column(localDates().between(LocalDate.of(2010, 12, 25), LocalDate.of(2020, 12, 25)))
	            .column("Valid")
	            .write("DataIntakeInput/ACCOUNT_.csv", noOfRecords, true);
	        csvs()
	        .column(m.intSeq().start(businessAccStartRange).increment(1))
	        .column("LOAN")
	        .column("Loan")
	        .column("ACTIVE")
	        .column(localDates().between(LocalDate.of(2010, 12, 25), LocalDate.of(2020, 12, 25)))
	        .column("")
	        .column("")
	        .column(ints().rangeClosed( 10000, 20000))
	        .column(ints().rangeClosed( 10000, 20000))
	        .column("branch")
	        .column(localDates().between(LocalDate.of(2010, 12, 25), LocalDate.of(2020, 12, 25)))
	        .column(ints().rangeClosed( 10000, 20000))
	        .column(ints().rangeClosed( 10000, 20000))
	        .column(localDates().between(LocalDate.of(2010, 12, 25), LocalDate.of(2020, 12, 25)))
	        .column("Valid")
	        .write("DataIntakeInput/ACCOUNT_.csv", noOfRecords, true);
			System.out.format("\nAccount CSV File Generated Successfully...");
	    }

		static private void createAccountRelationshipCSV(int noOfRecords,int individualStartRange,int individualAccStartRange,int businessStartRange,int businessAccStartRange) {
	    csvs()
	        .column("ACCOUNT_NUMBER")
	        .column("CUSTOMER_TYPE")
	        .column("CUSTOMER_ID")
	        .column("TYPE")
	        .write("DataIntakeInput/ACCOUNTRELATIONSHIP_.csv",1, false);

	    csvs()
	        .column(m.intSeq().start(individualAccStartRange).increment(1))
	        .column("INDIVIDUAL")
	        .column(m.intSeq().start(individualStartRange).increment(1))
	        .column("HOLDER")
	        .write("DataIntakeInput/ACCOUNTRELATIONSHIP_.csv",noOfRecords, true);

	    csvs()
	        .column(m.intSeq().start(businessAccStartRange).increment(1))
	        .column("BUSINESS")
	        .column(m.intSeq().start(businessStartRange).increment(1))
	        .column("HOLDER")
	        .write("DataIntakeInput/ACCOUNTRELATIONSHIP_.csv",noOfRecords, true);
		System.out.format("\nAccount Relationship CSV File Generated Successfully...");
	}


		static private void createIndividualBusinessRelationshipCSV(int noOfRecords,int individualStartRange,int businessStartRange) {
	 csvs()
	     .column("INDIVIDUAL_ID")
	     .column("BUSINESS_ID")
	     .column("RELATIONSHIP_TYPE")
	     .column("OWNERSHIP_PERCENTAGE")
	     .column("OWNERSHIP_STATUS")
	     .column("COMMENTS")
	     .write("DataIntakeInput/INDIVIDUALBUSINESSRELATIONSHIP_.csv",1, false);

	 csvs()
	     .column(m.intSeq().start(individualStartRange).increment(1))
	     .column(m.intSeq().start(businessStartRange).increment(1))
	     .column((fromStrings(relationshipType)))
	     .column(ints().rangeClosed(10,20))
	     .column((fromStrings(ownershipStatus)))
	     .column("Valid")
	     .write("DataIntakeInput/INDIVIDUALBUSINESSRELATIONSHIP_.csv",noOfRecords, true);
		System.out.format("\nIndividual Business Relationship CSV File Generated Successfully...");

	}


		static private void createAddressCSV(int noOfRecords,int individualStartRange,int businessStartRange) {
	 csvs()
	     .column("OWNER_TYPE")
	     .column("OWNER_ID")
	     .column("TYPE")
	     .column("IS_PRIMARY_FOR_TYPE")
	     .column("ADDRESS")
	     .column("CITY")
	     .column("ZIPCODE")
	     .column("COUNTRY")
	     .column("COMMENTS")
	     .column("ADDRESS_ID")
	     .column("STATE")
	     .write("DataIntakeInput/ADDRESS_.csv",1, false);

	 csvs()
	     .column("INDIVIDUAL")
	     .column(m.intSeq().start(individualStartRange).increment(1))
	     .column("WORK")
	     .column(fromStrings(booleanValues))
	     .column("100 Bell Street")
	     .column(cities().us())
	     .column(ints().rangeClosed(90000,100000))
	     .column("US")
	     .column("None")
	     .column(ints().rangeClosed(1000,3000))
	     .column(usStates())
	     .write("DataIntakeInput/ADDRESS_.csv",noOfRecords, true);

	 csvs()
	     .column("BUSINESS")
	     .column(m.intSeq().start(businessStartRange).increment(1))
	     .column("WORK")
	     .column(fromStrings(booleanValues))
	     .column("100 Bell Street")
	     .column(cities().us())
	     .column(ints().rangeClosed(90000,100000))
	     .column("US")
	     .column("None")
	     .column(ints().rangeClosed(3000,5000))
	     .column(usStates())
	     .write("DataIntakeInput/ADDRESS_.csv",noOfRecords, true);
		System.out.format("\nAddress CSV File Generated Successfully...");
	 }
	 

	static private void createEMAILAddressCSV(int noOfRecords,int individualStartRange,int businessStartRange) {
	  csvs()
	      .column("EMAIL_ID")
	      .column("OWNER_TYPE")
	      .column("OWNER_ID")
	      .column("EMAIL")
	      .column("IS_PRIMARY")
	      .write("DataIntakeInput/EMAILADDRESS_.csv",1, false);
	  
	  csvs()
	      .column(ints().rangeClosed(80000,90000))
	      .column("INDIVIDUAL")
	      .column(m.intSeq().start(individualStartRange).increment(1))
	      .column(emails())
	      .column(fromStrings(booleanValues))
	      .write("DataIntakeInput/EMAILADDRESS_.csv",noOfRecords, true);
	  
	  csvs()
	  .column(ints().rangeClosed(90000,100000))
	  .column("BUSINESS")
	  .column(m.intSeq().start(businessStartRange).increment(1))
	  .column(emails())
	  .column(fromStrings(booleanValues))
	  .write("DataIntakeInput/EMAILADDRESS_.csv",noOfRecords, true);
		System.out.format("\nEmail Address CSV File Generated Successfully...");
	}
	 
	 

	static private void createIdentificationDocumentCSV(int noOfRecords,int individualStartRange,int businessStartRange) {
	  csvs()
	      .column("OWNER_TYPE")
	      .column("OWNER_ID")
	      .column("EXPIRATION_DATE")
	      .column("TYPE")
	      .column("TYPE_DESCRIPTION")
	      .column("NUMBER")
	      .column("ISSUING_STATE")
	      .column("ISSUING_COUNTRY")
	      .column("COMMENTS")
	      .column("DOCUMENT_ID")
	      .write("DataIntakeInput/IDENTIFICATIONDOCUMENT_.csv",1, false);

	  csvs()
	      .column("INDIVIDUAL")
	      .column(m.intSeq().start(individualStartRange).increment(1))
	      .column(localDates().between(LocalDate.of(2010, 12, 25), LocalDate.of(2029, 12, 25)))
	      .column(fromStrings(identificationDocumentType))
	      .column("valid")
	      .column(ints().rangeClosed(2000,3000))
	      .column(usStates())
	      .column("US")
	      .column("None")
	      .column(ints().rangeClosed(200000,300000))
	      .write("DataIntakeInput/IDENTIFICATIONDOCUMENT_.csv",noOfRecords, true);

	  csvs()
	  .column("BUSINESS")
	  .column(m.intSeq().start(businessStartRange).increment(1))
	  .column(localDates().between(LocalDate.of(2010, 12, 25), LocalDate.of(2029, 12, 25)))
	  .column(fromStrings(identificationDocumentType))
	  .column("valid")
	  .column(ints().rangeClosed(2000,3000))
	  .column(usStates())
	  .column("US")
	  .column("None")
	  .column(ints().rangeClosed(300000,400000))
	  .write("DataIntakeInput/IDENTIFICATIONDOCUMENT_.csv",noOfRecords, true);
		System.out.format("\nIdentification Document CSV File Generated Successfully...");
	  } 

	 

	static private void createPhoneCSV(int noOfRecords,int individualStartRange,int businessStartRange) {
	  csvs()
	      .column("OWNER_TYPE")
	      .column("OWNER_ID")
	      .column("TYPE")
	      .column("IS_PRIMARY_FOR_TYPE")
	      .column("NUMBER")
	      .column("COMMENTS")
	      .column("PHONE_ID")
	      .column("EXTENSION")
	      .write("DataIntakeInput/PHONE_.csv",1, false);

	  csvs()
	      .column("INDIVIDUAL")
	      .column(m.intSeq().start(individualStartRange).increment(1))
	      .column(fromStrings(phoneType))
	      .column(fromStrings(booleanValues))
	      .column(ints().rangeClosed(100000000,900000000))
	      .column("valid number")
	      .column(ints().rangeClosed(500,900))
	      .column(ints().rangeClosed(11,99))
	      .write("DataIntakeInput/PHONE_.csv",noOfRecords, true);

	  csvs()
	  .column("BUSINESS")
	  .column(m.intSeq().start(businessStartRange).increment(1))
	  .column(fromStrings(phoneType))
	  .column(fromStrings(booleanValues))
	  .column(ints().rangeClosed(100000000,900000000))
	  .column("valid number")
	  .column(ints().rangeClosed(500,900))
	  .column(ints().rangeClosed(11,99))
	  .write("DataIntakeInput/PHONE_.csv",noOfRecords, true);
		System.out.format("\nPhone CSV File Generated Successfully...");
	  }

	static private void createTransactionCSV(int noOfRecords,int individualAccStartRange,int businessAccStartRange) {
	       //Headers
	       csvs()
	           .column("TRANSACTION_ID")
	           .column("TYPE")
	           .column("DATE")
	           .column("TIME")
	           .column("AMOUNT")
	           .column("BALANCE")
	           .column("SUBJECT_ACCOUNT_NUMBER")
	           .column("COUNTERPARTY_ACCOUNT_NUMBER")
	           .column("COUNTERPARTY_INSTITUTION")
	           .column("COUNTERPARTY_TYPE")
	           .column("COUNTERPARTY_ID")
	           .column("CONDUCTOR_ID")
	           .column("DESTINATION_COUNTRY")
	           .column("BRANCH_ID")
	           .column("CHANNEL")
	           .column("CURRENCY")
	           .column("COMMENTS")
	           .column("OPERATION")
	           .write("DataIntakeInput/TRANSACTION_.csv", 1, false);
	       csvs()
	           .column(ints().rangeClosed(90000,100000))
	           .column(fromStrings(transactionType))
	           .column(localDates().between(LocalDate.of(2021, 07, 16), LocalDate.of(2021, 07, 20)))
	           .column("12:31:26")
	           .column(ints().rangeClosed(40000,60000))
	           .column(ints().rangeClosed(5000,10000))
	           .column(m.intSeq().start(individualAccStartRange).increment(1))
	           .column(ints().rangeClosed(80000,100000))
	           .column("Universal Bank")
	           .column("")
	           .column(ints().rangeClosed(300,400))
	           .column(ints().rangeClosed(20,29))
	           .column("US")
	           .column(ints().rangeClosed(3000,4000))
	           .column("ATM")
	           .column("USD")
	           .column("None")
	           .column(fromStrings(transactionOperation))
	           .write("DataIntakeInput/TRANSACTION_.csv", noOfRecords, true);
	       csvs()
	       .column(ints().rangeClosed(90000,100000))
	       .column(fromStrings(transactionType))
	       .column(localDates().between(LocalDate.of(2021, 07, 16), LocalDate.of(2021, 07, 20)))
	       .column("12:31:26")
	       .column(ints().rangeClosed(40000,60000))
	       .column(ints().rangeClosed(5000,10000))
	       .column(m.intSeq().start(businessAccStartRange).increment(1))
	       .column(ints().rangeClosed(80000,100000))
	       .column("Universal Bank")
	       .column("")
	       .column(ints().rangeClosed(300,400))
	       .column(ints().rangeClosed(20,29))
	       .column("US")
	       .column(ints().rangeClosed(3000,4000))
	       .column("ATM")
	       .column("USD")
	       .column("None")
	       .column(fromStrings(transactionOperation))
	       .write("DataIntakeInput/TRANSACTION_.csv", noOfRecords, true);       
			System.out.format("\nTransaction CSV File Generated Successfully...");
	   }	
}