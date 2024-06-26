# [Metadata]  Author  Owais Jilani

# Common Page elements
oItemsPerPageDropdown = "//div/span[text()='Items per page']/following-sibling::div//h6"
oDropdownExpandedListItems = "//ul//span[@data-testid='default-text-component']"
oItemsPerPageDropdownListValue = "//ul[@role='listbox']/li[@data-value='$LOCATOR_DYNAMIC_PARAM$']"
oDropdownWithList = "//span[text()='$LOCATOR_DYNAMIC_PARAM$']/parent::div/following-sibling::div//div[@aria-haspopup='listbox']"
oInputValue = "xpath://span[text()='$LOCATOR_DYNAMIC_PARAM$']/parent::div//h6"
oSearchInputFields = "xpath://span[text()='$LOCATOR_DYNAMIC_PARAM$']/parent::div/following-sibling::div//input"
oDropdownCloseButton = "xpath://span[text()='$LOCATOR_DYNAMIC_PARAM$']/parent::button"
ocancelButtonC = "id:cancel"

# From Alert and Case page elements
oTopRightSideButtons = "//div[contains(@class, 'workbenchButtons')]//span"
oAlertCheckbox = "//input[@type='checkbox']/following-sibling::label"
oCreateButton = "txt:Create"
oConfirmButton = "txt:Confirm"
oShowResultsButton = "txt:Show Results"
oClearAllButton = "txt:Clear All"
oAddAttachmentButton = "txt:Add Attachment"
oSaveAttachmentButton = "txt:Save Attachment"
oAttachmentCommentInput = "css:textarea[placeholder='Add Comment here...']"
oSearchFieldDropdown = "xpath://li/span[text()]"
oSearchFieldCheckbox = "xpath://li/h6[text()]"
oSearchFields = "xpath://span[text()='$LOCATOR_DYNAMIC_PARAM$']/parent::div/following-sibling::div//h6"
oToolTipText = "css:[role='tooltip'] div"
oCommonLabelButtons = "css:span[aria-label='$LOCATOR_DYNAMIC_PARAM$'] button"
oTableCommonCheckbox = "//div[@col-id='checkbox']//label"
oSearchAdvSearchFieldsName = "xpath://form/div/following-sibling::div//span[@data-testid='default-text-component' and text()]"
oSearchTypeNames = "css:form span.MuiTypography-h3Bold"
# From Alert page elements robot file
oAddButton = "txt:Add"

#From Alert page elements robot file
oBody = "xpath://body"
oSearchMaximizeButton = "//button[@aria-label='Maximize']"
oSearchSectionCloseButton = "xpath://button[@aria-label='Close']"
oListLoc = "css:ul[role='listbox']>li>h6,ul[role='listbox']>li>span:first-child"
oCommonLoader = "//div[contains(@class, 'loader')]|//span[@role='progressbar']"
oTopRightCreateCaseButton = "css:div.workbenchButtons span[aria-label='Create Case'] button"

# Added By Owais - Elements Used in Util
oCommonButtonLocator = "xpath://span[contains(text(),'$LOCATOR_DYNAMIC_PARAM$')]/parent::div/following-sibling::div"
oCommonInputLocator = "xpath://span[contains(text(),'$LOCATOR_DYNAMIC_PARAM$')]/parent::div/following-sibling::div//input"
oCommonListLocContains = "xpath://*[contains(text(),'$LOCATOR_DYNAMIC_PARAM$')]/parent::li"
oCommonListLocator = "xpath://*[text()='$LOCATOR_DYNAMIC_PARAM$']/parent::li"
oSelectedListLocator = "xpath://span[contains(text(),'$LOCATOR_DYNAMIC_PARAM$')]/parent::div/following-sibling::div//h6"
oSelectedInputLocator = "xpath://span[contains(text(),'$LOCATOR_DYNAMIC_PARAM$')]/parent::div/following-sibling::div//input"
oAlertsSearchCloseListPrefix = "xpath://h6[contains(text(),'$LOCATOR_DYNAMIC_PARAM$')]/parent::div"

# ************Alert Table Locators Common *****************
oAlertsTableRowSourceCommon = "xpath:(//div[@col-id='source']/h6)['$LOCATOR_DYNAMIC_PARAM$']"
oAlertsTableRowCommon = "xpath:(//div[@class='ag-body-viewport ag-row-animation ag-layout-normal']//div[@aria-rowindex='$LOCATOR_DYNAMIC_PARAM$']/div//*[contains(@data-testid,'text-component')][1])"
oiSearchTableColumn = "//span[normalize-space()='$LOCATOR_DYNAMIC_PARAM$']/following::div[@col-id='sessionProperties.$LOCATOR_DYNAMIC_PARAM$']"
# oAlertsSummaryCommon = "xpath://span[text()='$LOCATOR_DYNAMIC_PARAM$']/parent::div//h6"
oAlertsSummaryCommon = "xpath://span[text()='$LOCATOR_DYNAMIC_PARAM$']/parent::div/following-sibling::div//h6"
oLogo = "//img[@alt='logo']"
oPaginationLastPage = "//li/button[@aria-label='Go to next page']/../preceding-sibling::li[1]/button"
oPaginationNextButton = "//li/button[@aria-label='Go to next page']"
oToastMessage = "//div[@class='Toastify']"
oConfirmButtonXpath = "//span[text()='Confirm']/parent::button"
oSearchFieldTypeButtonSelStatusCheck = "xpath://span[text()='$LOCATOR_DYNAMIC_PARAM$']/../following-sibling::div//h6/ancestor::button"
oTableDateCreatedText = "css:[col-id='createdOn'] h6"
oAdvSearchFields = "xpath://div[@class='MuiAccordion-region']//span[@data-testid='default-text-component' and text()]"
oMultiSelectListCheckbox = "css:ul[role='listbox'] input[type='checkbox'] + label"
oInputValueLocator = "css:form input[value]"
oCommentTextarea = "//textarea[contains(@id,'comment')]"
oTableHeaderRow = "xpath://div[@class='ag-header-cell-comp-wrapper']/div/span"
oCheckedCheckbox = "//input[@checked]"
oAuditTab = "//*[text()='Audit']"
oAuditTableElements = "//div[contains(@class, 'center-cols')]//h6"
oMultiselectCommonText = "//ul//h6"
# Alerts Account Notes Locator
oAccountNotesInput = "css:textarea[placeholder='Your note here...']"
oAlertsAccountNotesList = "css:[class='mt-1'] span"
oAlertsAccountNotesUsernameText = "//div[@class='mt-1']//span"
oAlertsAccountNotesDateText = "//div[@class='mt-1']/parent::span/div[position() mod 2]"
oAlertsNotesText = "//div[@class='mt-1']/ancestor::div/following-sibling::div/h6"
oAddAccountNotesButton = "txt:Add Account Notes"
oAccountNotesLimitMsgLocator = "//span[contains(text(),'maximum of 10')]"
oCancelButtonG = "//span[text()='Cancel']/parent::button"

oNoTableDataText = "xpath://div[contains(@class,'ag-overlay-no-rows-wrapper') and text()='There are no elements on this table']"

oSelectedCheckbox = "xpath://div[@aria-selected='true']"
oAlertIdOfSelectedCheckbox = "xpath://div[@aria-selected='true']/div[@col-id='alertId']/h6"

oSummaryFieldsText = "//span[text()='$LOCATOR_DYNAMIC_PARAM$']/following-sibling::div//h6"

oButtonCommon = "//span[text()='$LOCATOR_DYNAMIC_PARAM$']/parent::button"
