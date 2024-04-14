# [Metadata]  Author  Owais Jilani

# Cases Page Elements
oPageLoadCondition = "xpath://section//span[@data-testid='default-text-component' and text()='Cases']"
oCreateCaseCheckbox = "css:[data-testid='sentinelStart'] + div label span[data-testid='default-text-component']"
oCaseSelectChannelDropdown = "css:[data-testid='sentinelStart'] + div div[aria-haspopup='listbox'] h6"
oCaseSelectChannelDropdownOptions = "css:[data-testid='sentinelStart'] + div li[role='option']"
oCasePriorityAndCategoryButton = "css:button h6"
oCaseEditButton = "css:button svg[name='Edit3']"
oAddAlertsButton = "txt:Add Alerts"
oAddButton = "txt:Add"
oSaveAndViewCaseButton = "txt:Save and View Case"
oAddAttachmentInput = "xpath://span[text()='Add Attachments']/following-sibling::div//input"
oSummaryTextbox = "css:textarea#summary-text-field"
oAvailableCase = "css:div.ag-body-viewport input[type=checkbox]"
oCircularProgressBar = "css:circle.MuiCircularProgress-circle"
oCloseCaseButton = "xpath://span[@aria-label='Close Case']/button"
oCloseCaseResolution = "css:div[role='radiogroup'] h6"
oCaseCheckbox = "//div[@col-id='checkbox']//label"
oCommonRadioButtonOptions = "xpath://div[@class='MuiFormGroup-root css-1h7anqn']//h6"
oAdvSearchOptions = "xpath://div[@class='MuiAccordion-region']//span[@data-testid='default-text-component' and text()]"
oSearchFieldTypeButtonSelectedStatusCheck = "xpath://span[text()='$LOCATOR_DYNAMIC_PARAM$']/parent::div/following-sibling::div//h6/ancestor::button"
oCommonRadioButton = "xpath://h6[text()='$LOCATOR_DYNAMIC_PARAM$']/ancestor::label"

# [Metadata]  Author  Owais Jilani
oCreateCaseSearchSubjectsByName = "xpath://h6[text()='By Name']/parent::button"
oSubjectNameSubjectListRow = "xpath:(//label//h6)[$LOCATOR_DYNAMIC_PARAM$]"
oCreateCaseSearchSubjectsInput = "xpath://input[@placeholder='Search Subjects']"
oSubjectNameCheckbox = "xpath://h6[text()='$LOCATOR_DYNAMIC_PARAM$']/parent::span/preceding-sibling::div"
oSubjectDetailsBodyElements = "xpath://tbody//h6"
oCreateCaseSearchSubjectsByAccount = "xpath://h6[text()='By Account']/parent::button"
oSubjectAccountIdSubjectListRow = "xpath:(//li[@data-testid='form-control']/h6)[$LOCATOR_DYNAMIC_PARAM$]"
oSubjectAccountIDCheckbox = "xpath://h6[text()='$LOCATOR_DYNAMIC_PARAM$']/preceding-sibling::label/div"
oSaveAndViewCaseButtonXpath = "xpath://span[text()='Save and View Case']/parent::button"
oAddAlertsButtonXpath = "xpath://span[text()='Add Alerts']/parent::button"
oAlertsTableCheckboxColumnHeader = "xpath://div[@col-id='checkbox' and @role='columnheader']"
oAlertsTableTextHeaders = "xpath://div[@role='columnheader']//span[@data-testid='default-text-component']"

oSearchLabelButton = "//span[@aria-label='Search']/button"
oAssignCaseButton = "//span[@aria-label='Assign']/button"
oCreateCaseButton = "//span[@aria-label='Create Case']/button"

oAnalystComboboxInput = "//input[@role='combobox']"
oRelativeCaseIDToCheckbox = "ancestor::div[@col-id='checkbox']/following-sibling::div[@col-id='fullKey']/h6"
oAssignCaseResolution = "//div[@role='radiogroup']//h6[text()='$LOCATOR_DYNAMIC_PARAM$']"
oCloseAssignErrorPopup = "//span[text()='Exceeded Maximum Limit']/parent::div/preceding-sibling::div//button"
oCaseId = "//div[contains(@class,'left-cols')]//div[@col-id='fullKey']"
oResolutionCloseCaseRadioButtons = "//h6[text()='$LOCATOR_DYNAMIC_PARAM$']/ancestor::label//input"

oCaseIdCloseCasePopup = "//h6[contains(text(),'close case?')]/following-sibling::div/span"
oUnusualActivityReviewedCheckbox = "//input[@id='UNUSUAL_ACTIVITY_REVIEWED']"
oNewActivityReviewedCheckbox = "//input[@id='NEW_ACTIVITY_REVIEWED']"
oFraudClassifierCloseCase = "//div[@role='radiogroup']//input[@id='fraudClassifier-dropdown']/preceding-sibling::div//h6"
oFraudTypeCloseCase = "//div[@role='radiogroup']//input[@id='fraudType-dropdown']/preceding-sibling::div//h6"
oAmountAtRisk = "//span[text()='Amount at Risk($)']"
oAmountAtLoss = "//span[text()='Amount at Loss($)']"
oOverrideAmountAtRiskInput = "//textarea[@id='overrideAmountAtRisk-text-field']"
oCloseCaseMultiselectCommonCheckbox = "//ul//label"
oNotFraudCheckboxOptions = "//span[text()='$LOCATOR_DYNAMIC_PARAM$']/ancestor::label"

oTableDataText = "css:div[col-id='$LOCATOR_DYNAMIC_PARAM$']"
oCaseSummaryText = "xpath://span[contains(text(),'$LOCATOR_DYNAMIC_PARAM$')]/parent::div//h6"
oCaseSummaryHeaderText = "xpath://span[contains(text(),'$LOCATOR_DYNAMIC_PARAM$')]"

oOpenCaseAgingDropdown = "xpath://span[text()='Open Case Aging']/parent::div/following-sibling::div/parent::div/following-sibling::div//h6[text()='Select Value']"
oOpenCaseAgingInputFieldHeader = "xpath://span[text()='Open Case Aging']"
oAdvanceSearchInputCheckbox = "css:span.user-select-none"
oAdvanceSearchCheckboxLinkedCase = "xpath://input[@id='linkedCases']"
oAdvanceSearchCheckboxLinkedAlertsEvents = "xpath://input[@id='linkedAlertsEvents']"

oCaseLeftTabs = "xpath://section//button//span[text()]"

oAlertIdSaveAndContinuePage = "//span[contains(text(),'Total Alerts')]/following-sibling::div//span[text()='Alert ID']/following-sibling::div//h6"
oTotalAlerts = "xpath://span[contains(text(),'Total Alerts')]"
oAlertIdChannelPriority = "xpath://span[text()='$LOCATOR_DYNAMIC_PARAM$']/following-sibling::div//h6"
oAlertRiskScore = "xpath://span[text()='Alert ID']/following-sibling::div//span[@data-testid]"
oPriorityCategoryCreateCaseButton = "xpath://h6[text()='$LOCATOR_DYNAMIC_PARAM$']/parent::button"
oInputAmountAtRisk = "css:input[id='amountAtRisk-text-field']"
oInputAmountLost = "css:input[id='amountLost-text-field']"

oErrorAddAttachment = "xpath://span[text()=\"Operation 'ADDATTACHMENTCASEPERMISSION' failed!\"]"
oFileSizeErrorAddAttachment = "xpath://span[text()='The file must be under 20 MB']"
oBackArrowAddAttachment = "css:button[aria-label='back-arrow']"

oLinkViewDetails = "xpath://span[text()='View Details']"
oCaseSummaryDetail = "xpath://div[@data-testid='summary-section']//span[text()='$LOCATOR_DYNAMIC_PARAM$']/parent::div//h6"
oCaseSummaryDetailRiskScore = "xpath://div[@data-testid='summary-section']//span[text()='Alert ID']/parent::div//h6/parent::span/following-sibling::span"

oAmountAtRiskInput = "id:amountAtRisk-text-field"
oAmountLostInput = "id:amountLost-text-field"
oCaseCreatedSummaryPageHeader = "//span[text()='SUMMARY']"
oAnalystComboboxList = "//div[@data-popper-placement='bottom']"
oAssignButton = "//span[@aria-label='Assign']/button"

oTabsCaseSummary = "xpath://button[contains(@class,'Nice-Dark')]"

oCaseSummarySection = "xpath://div[contains(@class,'text-break')]/parent::div//span[contains(text(),'$LOCATOR_DYNAMIC_PARAM$')]"
oCaseSummaryEmptySubjects = "xpath://div[contains(@class,'text-break')]/parent::div//span[contains(text(),'Subjects')]/following-sibling::div//span[text()='There are no elements on this table']"
oCaseSummaryEmptyAlerts = "xpath://div[contains(@class,'text-break')]/parent::div//span[contains(text(),'Alerts')]/following-sibling::div//span[text()='There are no elements on this table']"

oNarrativeIntroductionInput = "css:textarea[id='introduction-text-field']"
oNarrativeBodyInput = "css:textarea[id='body-text-field']"
oNarrativeConclusionInput = "css:textarea[id='conclusion-text-field']"

oNarrativeFraudClassifierDropdown = "xpath://span[text()='Fraud Classifier']/parent::div/following-sibling::div//h6"
oNarrativeFraudTypeDropdown = "xpath://span[text()='Fraud Type']/parent::div/following-sibling::div//h6"

oNarrativeDropdownList = "xpath://li/h6[text()]"

oAuditTableDateTime = "xpath://div[@col-id='startDate']"
oAuditTableAction = "xpath://div[@col-id='auditLog.userAction']"
oAuditTableField = "xpath://div[@col-id='auditValuesField']"
oAuditTableOldValue = "xpath://div[@col-id='auditValuesBefore']"
oAuditTableNewValue = "xpath://div[@col-id='auditValuesAfter']"

