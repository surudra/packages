// jQuery File Tree Plugin - Customized version for CrushFTP
// Customized for ActiveTransfer
//
// Version 1.01
//
// Cory S.N. LaViska
// A Beautiful Site (http://abeautifulsite.net/)
// 24 March 2008
//
// Visit http://abeautifulsite.net/notebook.php?article=58 for more information
//
// Usage: $('.fileTreeDemo').fileTree( options, callback )
//
// History:
//
// 1.01 - updated to work with foreign characters in directory/file names (12
// April 2008)
// 1.00 - released (24 March 2008)
//
// TERMS OF USE
//
// This plugin is dual-licensed under the GNU General Public License and the MIT
// License and
// is copyright 2008 A Beautiful Site, LLC.
//
// Customized for ActiveTransfer

/*Upload bar latest localizations, do not change this, use localization instructions*/
window.locale = {
    "fileupload": {
        "errors": {
            "maxFileSize": "File is too big",
            "minFileSize": "File is too small",
            "acceptFileTypes": "Filetype not allowed",
            "maxNumberOfFiles": "Max number of files exceeded",
            "uploadedBytes": "Uploaded bytes exceed file size",
            "emptyResult": "Empty file upload result",
            "fileAvailableInSelectedFolder" : "File already added to upload in the same folder",
            "fileExistOnServer" : "File exist on server",
            "fileBiggerThanAllowed" : "File is bigger than allowed size",
            "dirNoWritable" : "You can not upload to this directory",
            "blockUploadingDirs" : "Uploading directory is not allowed",
            "true" : "true"
        },
        "error": "Error",
        "start": "Start",
        "waiting" : "Waiting...",
        "uploading" : "Uploading : ",
        "reupload" : "Re-Upload",
        "share" : "Share",
        "cancel": "Cancel",
        "destroy": "Delete",
        "overwrite" : "Overwrite",
        "uploadTo" : "Upload to : ",
        "pause" : "Pause",
        "errorLabel" : "Error : ",
        "details" : "Details",
        "uploadedInLabelText" : "Uploaded in : ",
        "atAvgSpeedOfLabelText" : "at Avg. Speed of : ",
        "uploadCompletedText" : "Upload Completed",
        "uploadedFileText" : "File uploaded to server",
        "uploadedMultipleFilesText" : "All files uploaded."
    }
};

// FTP WebInterface Localization options
var localizations = {};
localizations.slideshow = {};
//WebInterface
localizations.FilterText = localizations.FilterTextBasket = "Filter:";
localizations.ClearFilterLinkText = localizations.ClearFilterLinkTextBasket = "Clear";
localizations.FileCounterItemsText = "Items";
localizations.FileCounterFoldersText = "Folders";
localizations.FileCounterFilesText = "Files";
localizations.FileCounterHiddenItemsText = "Hidden Items";
localizations.ThumbnailViewLinkText = localizations.ThumbnailViewLinkTextBasket = "Thumbnail View";
localizations.TreeViewLinkText = localizations.TreeViewLinkTextBasket = "Tree View";
localizations.DownloadResumeTextLabelBasket = "Resume"
localizations.BackToTopLinkText = "Back to top";
localizations.FilesNotAvailableMessage = "No files available";
localizations.CopyNoFilesSelectedMessage = "Please select files/folders to copy";
localizations.CopyOnlyFilesMessage = "You can cut/copy only files, selected folders will be ignored";
localizations.DeleteNoFilesSelectedMessage = "Please select files/folders to delete";
localizations.UnzipNoFilesSelectedMessage = "Please select file to unzip";
localizations.CutNoFilesSelectedMessage = "Please select files/folders to cut";
localizations.pagingPrevText = "Prev";
localizations.pagingNextText = "Next";
localizations.pagingEllipseText = "...";
localizations.FilterItemCountText = "(Items with phrase \"{filterVal}\" : {totalItems} , Folders: {folders} Files: {files})";
localizations.TotalItemsInDirMsgText = "(Total items in directory {count})";
localizations.quotaAvailableLabelText = "available";

localizations.WelcomeNoteSubmitFormFailureMsgText = "Error: Problem while saving data";
localizations.TreeviewSpecificActionMsgTitleText = "For tree view only";
localizations.TreeviewSpecificActionMsgDescText = "This is specific to tree view only";
localizations.PasswordExpiringMsgText = "Password Expiring Soon<br/>Use User Options button to change.";
localizations.PasswordNotMatchingMsgText = "New passwords don't match.";
localizations.PasswordMustBeComplexMsgText = "Password must be more complex.";
localizations.PasswordChangedMsgText = "Password changed.  Please login using the new password.";
localizations.AppletLoadingFailedMsgText = "Applet failed while uploading";
localizations.DownloadStartedAlertTitleText = "Download has started";
localizations.DownloadCompletedText = "[Download Completed]";
localizations.DownloadCompletedPathText = " Downloaded to : ";
localizations.DownloadStartedAlertDescText = "Please select location to save your file(s) to proceed";
localizations.LogoutButtonText = "Logout";
localizations.browserUploaderNativeUploadTipSetTitle = "Upload files using browser uploader.";
localizations.browserUploaderAdvancedUploadTipSetTitle = "Upload files using the advanced uploader, <br>it allows folders and may accelerate the transfer.";
localizations.browserUploaderDragDropHoverLabelText = "Drop files here to upload";
localizations.appletUploaderDropPanelLabelText = "&darr; Drop files here to upload &darr;";

//Sharing Window
localizations.ShareWindowHeaderText = "Sharing Files";
localizations.ShareWindowFilesSharingLabelText = "Sharing :";
localizations.ShareWindowShareTypeLabelText = "Share Type :";
localizations.ShareWindowShareTypeLabelCopyText = "Copy";
localizations.ShareWindowShareTypeLabelMoveText = "Move";
localizations.ShareWindowShareTypeLabelReferenceText = "Reference";
localizations.ShareWindowShareToInternalUserLabelText = "Internal Share";
localizations.ShareWindowShareToExternalUserLabelText = "External Share";
localizations.ShareWindowDownloadLabelText = "Download";
localizations.ShareWindowUploadLabelText = "Upload";
localizations.ShareWindowDeleteLabelText = "Delete";
localizations.ShareWindowSendEmailLabelText = "Send Email :";
localizations.ShareWindowDirectLinkLabelText = "Direct link to file?";
localizations.ShareWindowExpiresLabelText = "Expires :";
localizations.ShareWindowFromLabelText = "From : ";
localizations.ShareWindowToLabelText = "To : ";
localizations.ShareWindowCCLabelText = "CC : ";
localizations.ShareWindowBCCLabelText = "BCC : ";
localizations.ShareWindowSubjectLabelText = "Subject : ";
localizations.ShareWindowBodyLabelText = "Body : ";
localizations.ShareWindowAdvancedLabelText = "Advanced";
localizations.ShareWindowAttachThumbsLabelText = "Attach Thumbnail";
localizations.ShareWindowAccessLabelText = "Full Access (read, write, delete) ";
localizations.ShareWindowSendButtonText = "Send";
localizations.ShareWindowCancelButtonText = "Cancel";
localizations.ShareWindowUsernameMethodLabelText = "Share Method : ";
localizations.ShareWindowUsernameLabelText = "Share to Internal User";
localizations.ShareWindowUsernamesLabelText = "Usernames : ";
localizations.ShareWindowUsernamesLabelHelpText = "(Separate multiple usernames with commas.)";
localizations.ShareActionCompleteShareUsernamesText = "The following users have now been granted access to the shared items.";
localizations.ShareActionCompleteUsernameText = "Username: ";
localizations.ShareActionCompletePasswordText = "Password: ";
localizations.ShareActionCompleteLinkText = "Link";
localizations.ShareActionCompleteOkButtonText = "Ok";
localizations.ShareActionEmailValidationFailureHelpToolTip = "Please enter valid email address. You can enter multiple email addresses at once separated by comma. ie. <strong>bob@email.com, john@email.com,...</strong>";
//Copy direct link window
localizations.CopyLinkWindowHeaderText = "Copy direct link.";
localizations.CopyLinkText = "Copy link";
//Create folder window
localizations.CreateFolderWindowHeaderText = "Create new folder.";
localizations.CreateFolderInputDefaultFolderName = "New Folder";
localizations.CreateFolderWindowNavigateToFolderCheckboxText = "Navigate to the folder after creation ";
localizations.CreateFolderButtonText = "Create";
//Browser uploader window
localizations.BrowserUploaderWindowHeaderText = "Upload file";
localizations.BrowserUploaderUploadDetailsTabHeaderText = "Upload Details";
localizations.BrowserUploaderUploadFilesTabHeaderText = "Upload Files";
localizations.BrowserUploaderAdvancedBrowseButtonText = "Advanced Browse..";
localizations.BrowserUploaderStartUploadingLinkText = "Start Uploading";
localizations.BrowserUploaderClearCompletedLinkText = "Clear Completed";
localizations.BrowserUploaderResumeCheckboxText = "Resume";
localizations.BrowserUploaderFormResetButtonText = "Reset";
localizations.BrowserUploaderFormNextButtonText = "Next";
localizations.BrowserUploaderFileAddedAlreadyText = "This file has already been added.";
localizations.BrowserUploaderFileAddedAlreadyDetailsText = "{0} has already been added.";
localizations.BrowserUploaderMultiFileAddedAlreadyText = "These files are already added.";
localizations.BrowserUploaderMultiFileAddedAlreadyDetailsText = "{0} are already added.";
localizations.BrowserUploaderSelectedFilesGroupText = "File Group : ";
localizations.BrowserUploaderSelectedFileRemoveLinkText = "Remove";
localizations.BrowserUploaderSelectedFileWillBeUploadedText = "Will be uploaded to";
localizations.BrowserUploaderSelectedFileOverwriteText = "Overwrite";
localizations.BrowserUploaderSelectedFileWillBeOverwrittenText = "will be overwritten";
localizations.BrowserUploaderSelectedFileExistsText = "File exist";
localizations.BrowserUploaderSelectedFileAttentionRequiredText = "Attention Required";
localizations.BrowserUploaderSelectedFileIgnoreLinkText = "Ignore";
localizations.BrowserUploaderSelectedFileDoneText = "Done";
localizations.BrowserUploaderSelectedFileUploadedText = "Uploaded to";
localizations.BrowserUploaderSelectedFileReUploadLinkText = "re-upload";
localizations.BrowserUploaderSelectedFileReDownloadLinkText = "re-download";
localizations.BrowserUploaderSelectedFileDismissLinkText = "Dismiss";
localizations.BrowserUploaderSelectedFileCancelLinkText = "Cancel";
localizations.BrowserUploaderSelectedFilePauseLinkText = "Pause";
localizations.BrowserUploaderSelectedFilePausedStatusText = "Paused";
localizations.BrowserUploaderSelectedFileResumeLinkText = "Resume";
localizations.BrowserUploaderAdvancedUploadingFilesText = "Total {0} File(s)";
localizations.BrowserUploaderAdvancedUploadingFilesStatusText = "{0} of {1} item(s) ";
localizations.BrowserUploaderAdvancedUploadingFilesToText = "Uploading to : ";
localizations.BrowserUploaderAdvancedUploadingSpeedText = "Current Speed : ";
localizations.BrowserUploaderAdvancedUploadingAverageSpeedText = "Avg. Speed : ";
localizations.BrowserUploaderAdvancedUploadingTimeText = "<div class='time'> Time: Elapsed: <span class='elapsed'>{0}</span> <span class='remained'>, Remaining : {1}</span></div>";
localizations.BatchCompleteText = "Result";
localizations.BatchComplete = "Transfers Acknowledged.";
localizations.BrowserUploaderSpeedTimeCalculatingText = "Calculating..";
localizations.BrowserUploaderProblemWhileTransferMsgText = "Problem while transferring";
localizations.BrowserUploaderCancelledUploadMsgText = "Cancelled uploading";
localizations.BrowserUploaderAlertWhileNavigatingAwayMsgText = "Your file(s) are currently uploading.  If you navigate away from this page you will lose them.  Are you sure you want to exit this page?";
localizations.BrowserDownloadAlertWhileNavigatingAwayMsgText = "Your files are currently downloading. If you navigate away from this page you will lose them.  Are you sure you want to exit this page?";
localizations.NoUploadInDirGrowlText = "Upload not allowed";
localizations.NoUploadInDirGrowlDesc = "Uploading items to selected directory is not allowed";
localizations.AdvancedUploadDirNotAllowedText = "Uploading directory is not allowed";
localizations.AdvancedUploadDirNotAllowedDescText = "Directories can not be uploaded, select only files";
localizations.uploadConfirmCancelUploadText = "Are you sure you wish to cancel this upload?";
localizations.uploadConfirmCancelUploadAfterFormText = "Are you sure you wish to cancel upload for last selected {count} item(s)?";

//New upload bar localizations
localizations.browseFileLabelByClass = "Add files...";
localizations.advancedUploadResumeLabelByClass = "Resume";
localizations.filesToUploadQueueWindowHeader = "Files to upload";
localizations.uploadWindowStartUploadingByClass = "Start Uploading";
localizations.uploadWindowCancelUploadingByClass = "Cancel Uploading";
localizations.uploadWindowClearUploadedByClass = "Clear uploaded";
localizations.uploadWindowOverwriteAllByClass = "Overwrite all";
localizations.uploadWindowRemoveAllWithErrorsByClass = "Remove all with errors";
localizations.uploadWindowSummaryFilesByClass = "Files : ";
localizations.uploadWindowSummarySizeByClass = ", Upload size : ";
localizations.uploadBarShowHideFilesSetTitleClass = "Show/Hide selected files";
localizations.uploadBarAttentionTitle = "Now add files from upload bar";
localizations.uploadBarAttentionText = "Use upload bar to add files to upload. Click on \"" + localizations.browseFileLabelByClass + "\" button to add files";
localizations.uploadBiggerFileNoticeTitleText = "For bigger files use advanced upload";
localizations.uploadBiggerFileNoticeDescText = "<span class='growlNote'>It is advised to use advanced upload for bigger files, it allows to upload files easily and has <em>auto resume</em> feature. <br><br> (You can switch upload mode in Upload Bar)</span><br><img src='/WebInterface/jQuery/images/UploadBarGuide.png' style='padding-top:10px;margin-left:-45px;' title='How to switch upload mode'>";

localizations.globalProgressbarSkipLabelByClass = "Skip";
localizations.globalProgressbarPauseLabelByClass = "Pause";
localizations.globalProgressbarStopLabelByClass = "Stop";

localizations.popupOpenInSeparateWindowText = "Open in a separate window";
localizations.customFormPasswordMatchValidationFailedText = "Password does not match";
localizations.customFormCompareValueMatchValidationFailedText = "Values does not match";

localizations.syncAppName = "CrushSync";

if(typeof window.locale != "undefined")
{
    window.locale.fileupload.SwitchToNormalUpload = "Switch to Normal Upload";
    localizations.uploadWindowUploadTypeSwitchSetTitleClass = window.locale.fileupload.SwitchToAdvancedUpload = "Switch to Advanced Upload.<div style='font-size:11px;width:500px;margin:5px 0px;'>The advanced mode will accelerate transfers. It can automatically resume if a transfer fails, and can upload entire folders all at once.<br><br>It is the fastest way to upload files.<br>(Advanced mode requires the Java Applet plugin from www.java.com to be installed.)</div>";
}

//Search window
localizations.SearchWindowHeaderText = "Search";
localizations.SearchWindowKeywordsLabelText = "Keywords :";
localizations.SearchWindowExactLabelText = "Exact?";
localizations.SearchWindowByClassModifiedLabelText = "Modified";
localizations.SearchWindowByClassDateFormatLabelText = "(mm/dd/yyyy) ";
localizations.SearchWindowSizeLabelText = "Size is ";
localizations.SearchWindowTypeLabelText = "Type is a";
localizations.SearchWindowSizeLabelText = "Size is ";
localizations.SearchWindowSizeUnitLabelText = "(Kilobytes)";
localizations.SearchWindowSearchButtonText = "Start Search";
localizations.SearchWindowCancelButtonText = "Cancel";
localizations.SearchResultDisplayText = "Search Result:";
localizations.SearchResultClearLinkText = "(Clear Search Filter)";
localizations.SearchFormModifiedOptionAfterText = "After";
localizations.SearchFormModifiedOptionBeforeText = "Before";
localizations.SearchFormSizeOptionBiggerThanText = "Bigger Than";
localizations.SearchFormSizeOptionSmallerThanText = "Smaller Than";
localizations.SearchFormItemTypeOptionFileText = "File";
localizations.SearchFormItemTypeOptionFolderText = "Folder";
localizations.SearchProcessNotificationText = "Processing... ";
localizations.SearchProcessCancelText = "Cancel";
//Multiple file selection options
localizations.ItemsSelectionDisplayText = "All <strong>{count}</strong> items on this page are selected.";
localizations.ItemsSelectionSelectAllItemsInDir = "Select all <strong>{total_items}</strong> items in <strong>{list_type}</strong> (including hidden items)</span>";
localizations.ItemsSelectionSelectedAllItemsInDir = "All <strong>{total_items}</strong> items in <strong>{list_type}</strong> (including hidden items) are selected";
localizations.ItemsSelectionClearSelection = "Clear selection";
localizations.ItemsSelectionShowingFolderText = "Current Folder";
localizations.ItemsSelectionShowingFilteredItemsText = "Current filtered list";
localizations.ItemsSelectionShowingSearchedItemsText = "Search result";
//User options window
localizations.UserOptionsWindowHeaderText = "Preferences";
localizations.UserOptionsWindowHideItemsStartWithDotLabelText = "Hide '.' Items ";
localizations.UserOptionsWindowHideCheckboxLabelText = "Hide Checkbox Column ";
localizations.UserOptionsWindowHideFilterLabelText = "Hide Filter Section ";
localizations.UserOptionsWindowAutostartUploadLabelText = "When choosing file to upload, auto start upload. ";
localizations.UserOptionsWindowLoadJavaAppletLabelText = "When loading the interface, load the Java applet.";
localizations.UserOptionsWindowDisableCompressionLabelText = "Disable compression on the Java applet. ";
localizations.UserOptionsWindowChangePasswordHeaderText = "Change your password ";
localizations.UserOptionsWindowChangePasswordCurPassLabelText = "Current Password: ";
localizations.UserOptionsWindowChangePasswordNewPassLabelText = "New Password: ";
localizations.UserOptionsWindowChangePasswordConfirmPassLabelText = "Confirm Password:";
localizations.UserOptionsWindowChangePasswordButtonText = "Change Password";
localizations.UserOptionsWindowChangePasswordGenerateRandomButtonText = "Generate random password";
localizations.UserOptionsWindowChangePasswordGenerateRandomUseItLinkText = "Use this";
localizations.UserOptionsWindowChangePasswordGenerateRandomCancelLinkText = "Cancel";
//Main checkbox context menu options
localizations.MainCheckboxContextMenuToggleText = "Toggle";
localizations.MainCheckboxContextMenuCheckAllText = "Check All";
localizations.MainCheckboxContextMenuUncheckAllText = "Un-check All";
//Keywords window
localizations.KeywordsWindowHeaderText = "Keywords";
localizations.KeywordsWindowUpdateLinkText = "Update";
localizations.KeywordsWindowCancelLinkText = "Cancel";
//File basket
localizations.BasketHeaderText = "Files in the Basket";
localizations.BasketClearAllLinkText = "Clear all";
localizations.BasketDownloadLinkText = "Download Basket";
localizations.BasketDownloadAdvancedLinkText = "Download Basket Advanced";
localizations.BasketNoFilesAvailableText = "No Files Available";
localizations.BasketRemoveLinkText = "Remove";
localizations.BasketTotalItemText = "{0} Items ";
localizations.BasketFileAddedAlreadyText = "File already added to the basket";
localizations.BasketFileAddedAlreadyDetailsText = "Selected file is already available in the basket";
localizations.BasketNothingSelectedToAddText = "Nothing selected to add to the basket";
localizations.BasketNothingSelectedToAddDetailsText = "&nbsp;";
localizations.BasketClearAllConfirmMessage = "Are you sure you wish to clear all selected files in Basket?";
//Paste form panel
localizations.PasteFormHeaderText = "Paste";
localizations.PasteFormResetButtonText = "Reset";
localizations.PasteFormPasteButtonText = "Paste";
localizations.PasteFormErrorHeaderText = "Problem while pasting";
localizations.PasteFormErrorDetailsText = "There was a problem while pasting items.<br />Error : {0}";
localizations.PasteFormErrorNothingToPasteText = "There is nothing to paste";
localizations.PasteSelectDirectoryWarning = "Please select a target to paste copied items";
localizations.PasteSelectSingleDirectoryWarning = "Please select single target to paste copied items";
//Welcome form panel
localizations.WelcomeFormHeaderText = "Welcome";
localizations.WelcomeFormOkButtonText = "OK";
//Slideshow popup
localizations.SlideshowPopupHeaderText = "Slideshow";
//Manage Share window
localizations.ManageShareWindowHeaderText = "Manage Shares";
localizations.ManageShareWindowRefreshLinkText = "Refresh";
localizations.ManageShareWindowDeleteSelectedLinkText = "Delete Selected Items";
localizations.ManageShareWindowDeleteLinkText = "Delete";
localizations.ManageShareWindowGridLinkLabelText = "Link";
localizations.ManageShareWindowGridFromLabelText = "From";
localizations.ManageShareWindowGridToLabelText = "To";
localizations.ManageShareWindowGridCCLabelText = "CC";
localizations.ManageShareWindowGridBCCLabelText = "BCC";
localizations.ManageShareWindowGridSubjectLabelText = "Subject";
localizations.ManageShareWindowGridBodyLabelText = "Body";
localizations.ManageShareWindowGridShareTypeLabelText = "Share Type";
localizations.ManageShareWindowGridUserNameLabelText = "Username";
localizations.ManageShareWindowGridPasswordLabelText = "Password";
localizations.ManageShareWindowGridAttachedLabelText = "Attached in Email?";
localizations.ManageShareWindowGridUploadLabelText = "Upload Allowed?";
localizations.ManageShareWindowGridPathsLabelText = "Paths";
localizations.ManageShareWindowGridCreatedLabelText = "Created";
localizations.ManageShareWindowGridExpiresLabelText = "Expires";
localizations.ManageShareWindowGridSharedItemsLabelText = "Shared Items";
localizations.ManageShareWindowGridDownloadsLabelText = "Downloads";
localizations.ManageShareWindowNothingToShowMessageText = "Nothing to display";
localizations.ManageShareWindowDeleteAccountConfirmationText= "Are you sure you wish to delete selected {count} account(s) ?";
localizations.ManageShareWindowFilterText = "Filter :";
localizations.ManageShareWindowClearFilterText = "Clear";
localizations.ManageShareWindowNextItemText = "Next";
localizations.ManageShareWindowPrevItemText = "Prev";
localizations.ManageShareWindowSelectSimilarText = "Select Similar";

//Rename widndow and panel
localizations.RenameWindowHeaderText = "Rename";
localizations.RenamePanelSaveLinkText = "Save";
localizations.RenamePanelCancelLinkText = "Cancel";

localizations.ZipNameWindowHeaderText = "Zip file name";
localizations.ZipNamePanelSaveLinkText = "Ok";
localizations.ZipNamePanelCancelLinkText = "Cancel";

localizations.SyncAppNameWindowHeaderText = "Sync application download";
localizations.SyncAppDownloadYourPassText = "Your Password : ";
localizations.SyncAppDownloadAdminPassText = "Admin Password : ";
localizations.SyncAppNamePanelSaveLinkText = "Ok";
localizations.SyncAppNamePanelCancelLinkText = "Cancel";

//Tooltip info
localizations.TooltipNameLabelText = "Name";
localizations.TooltipSizeLabelText = "Size";
localizations.TooltipModifiedLabelText = "Modified";
localizations.TooltipKeywordsLabelText = "Keywords";

//Form alerts and notifications
localizations.FormValidationFailText = "One or more required items are not entered or not entered properly. Enter proper value for the items with * in below form";
localizations.FormEmailValidationFailText = "<br> - Enter valid email address for email field(s)";
localizations.DeleteConfirmationMessageText = "{0} folder(s) and {1} file(s) will be deleted.\n\nItems: {2} Once deleted it can not revert back.";
localizations.DeleteConfirmationMessageRemoveAllItemsInDirText = "All items in folder \"{folder_name}\" will be deleted.\n\nTotal {count} items will be deleted.\n\nOnce deleted it can not revert back";
localizations.CopyActionGrowlText = "Total {0} folder(s) and {1} file(s) copied.";
localizations.CutActionGrowlText = "Total {0} folder(s) and {1} file(s) cut.";
localizations.NothingSelectedGrowlText = "Nothing selected";
localizations.ShareNothingSelectedGrowlText = "Nothing selected to share";
localizations.DownloadNothingSelectedGrowlText = "Nothing selected to download";
localizations.RenameNothingSelectedGrowlText = "Nothing selected to rename";
localizations.PreviewNothingSelectedGrowlText = "Nothing selected for preview";
localizations.NoPreviewGrowlText = "Preview";
localizations.NoPreviewGrowlDesc = "No preview available for selected item";
localizations.ProblemWhileRenamingGrowlText = "Problem while renaming";
localizations.ProblemWhileRenamingDescGrowlText = "There was a problem while renaming. Please retry. Error : ";
localizations.ProblemWhileSharingGrowlText = "Problem while sharing";
localizations.ProblemWhileSharingDescGrowlText = "There was a problem while sharing a file. Please retry";
localizations.DirectLinkDescGrowlText = "Right click on item and click on copy direct link";
localizations.UpdateKeywordDescGrowlText = "Right click on item and click on update keywords";
localizations.QuickViewNothingToShowGrowlText = "Error : Nothing to show in quick view";
localizations.QuickViewNoItemsAvailableGrowlText = "No items available";
localizations.QuickViewRotateClockwiseTooltipText = "Rotate Clockwise";
localizations.QuickViewRotateCounterClockwiseTooltipText = "Rotate Counter-Clockwise";
localizations.QuickViewCurrentImagePositionText = "Item {current} of {total}";
localizations.ProblemWhileDeletingGrowlText = "Problem while deleting";
localizations.ProblemWhileDeletingDescGrowlText = "There was a problem while deleting. Please retry. Error : ";
localizations.ProblemWhileUnzipGrowlText = "Problem while unzipping file(s)";
localizations.ProblemWhileUnzipDescGrowlText = "There was a problem while unzipping. Please retry. Error : ";
localizations.ProblemWhileZipGrowlText = "Problem while zipping file(s)";
localizations.ProblemWhileZipDescGrowlText = "There was a problem while zipping. Please retry. Error : ";
localizations.ProblemWhileCreatingFolderGrowlText = "Problem while creating new folder";
localizations.ProblemWhileCreatingFolderDescGrowlText = "There was a problem while creating new folder. Please retry. Error : ";
localizations.JavaRequiredGrowlText = "Java Required";
localizations.JavaRequiredDescGrowlText = "Java must be installed for the advanced functions to work.<br/><br/>Please go to: <a target=\"_blank\" href=\"http://www.java.com/\" class=\"whiteError\">http://www.java.com/</a>";
localizations.JavaLoadingProblemGrowlText = "Problem while loading Java";
localizations.JavaLoadingProblemDescGrowlText = "There was a problem while loading Java, if Java is disabled in browser, please enable and try again.";
localizations.JavaAppletNotLoadedGrowlText = "Java Applet Not Loaded";
localizations.JavaAppletNotLoadedDescGrowlText = "You must first click the 'Advanced Browse...' button before drag and drop will be enabled.";
localizations.NoFilesFoundGrowlTitle = "No data found";
localizations.NoFilesFoundGrowlText = "Error : No data found for ";
localizations.AutoLogOutConfirmationTitle = "Auto Logout";
localizations.AutoLogOutConfirmationDesc = "You are about to be signed out due to inactivity";
localizations.AutoLogOutButtonText = "Stay logged in";
//Treeview header items
localizations.TreeviewHeaderNameText = "Name";
localizations.TreeviewHeaderSizeText = "Size";
localizations.TreeviewHeaderModifiedText = "Modified";
localizations.TreeviewHeaderKeywordsText = "Keywords";
//Selection menu items
localizations.SelectItemOptionLinkText = "Select";
localizations.SelectCheckboxContextMenuToggleText = "Toggle";
localizations.SelectCheckboxContextMenuCheckAllText = "All items";
localizations.SelectCheckboxContextMenuUncheckAllText = "None";
localizations.SelectCheckboxContextMenuCheckAllFilesText = "All files";
localizations.SelectCheckboxContextMenuCheckAllFoldersText = "All folders";
localizations.SelectCheckboxContextMenuCheckItemsWithDotText = "Items starting with \".\"";
localizations.SelectCheckboxContextMenuCheckTodayText = "Modified today";
localizations.SelectCheckboxContextMenuCheckWeekText = "Modified this week";
localizations.SelectCheckboxContextMenuCheckMonthText = "Modified this month";
localizations.SelectCheckboxContextMenuCheck2MonthsText = "Modified in last 60 days";
localizations.SelectCheckboxContextMenuCheck3MonthsText = "Modified in last 90 days";
// Page size selection menu item.
localizations.PageSizeSelectionLinkText = "Show {0} items on page";
//Webinterface labels
localizations.CopyrightText = "&copy; 2012 <a target=\"_blank\" href=\"http://www.softwareag.com/\">CrushFTP</a>";
localizations.PoweredByText = "Powered by <a target=\"_blank\" href=\"http://www.softwareag.com/\">CrushFTP</a>";
// Applet browse window title options
localizations.advancedUploadItemsSelectionWindowTitle = "Choose items to upload..";
localizations.advancedDownloadPathSelectionWindowTitle = "Choose path where to download..";
localizations.advancedOperationsDownloadStatus = "Downloading";
localizations.advancedOperationsUploadStatus = "Uploading";

localizations.maxAllowedDownloadSizeReached = "Download size exceeded the maximum allowed size"; //Header of growl to display when download reaches maximum allowed size
localizations.maxAllowedDownloadSizeReachedText = "Maximum size allowed to download : {size}. <br />Use the advanced downloader, or add to basket instead."; //Text of growl to display when download reaches maximum allowed size

// Change icon window items
localizations.ChangeIconWindowHeaderText = "Change icon ";
localizations.ChangeIconWindowInstructionsText = "Choose a small image to set as the icon for selected item:";
localizations.ChangeIconWindowSelectedFilesLabelText = "Selected file : ";
localizations.ChangeIconWindowCancelLinkText = "Cancel";
localizations.ChangeIconWindowUpdateLinkText = "Save";
localizations.ChangeIconFileSelectAlertText = "Please select image file to continue.";

//unzip operation
localizations.UnzipStartedAlertTitleText = "Unzip has started";
localizations.UnzipStartedAlertDescText = "Unzip operation has started for selected files";
localizations.UnzipCompletedAlertTitleText = "Unzip has completed";
localizations.UnzipCompletedAlertDescText = "Unzip operation has completed for selected files";

//zip operation
localizations.ZipStartedAlertTitleText = "Zip has started";
localizations.ZipStartedAlertDescText = "Zip operation has started for selected files";
localizations.ZipCompletedAlertTitleText = "Zip has completed";
localizations.ZipCompletedAlertDescText = "Zip operation has completed for selected files";

//Signup-Page
localizations.RegisterWindowProcessCompleteMessage = "You can login using registered user once it is enabled by admin.";

//Data size format items
localizations.dataFormatBytes = "bytes";
localizations.dataFormatKiloBytes = "KB";
localizations.dataFormatMegaBytes = "MB";
localizations.dataFormatGigaBytes = "GB";
localizations.dataFormatTeraBytes = "TB";

localizations.loadingIndicatorText = "Please wait...";

//Server message localized
localizations.share_complete = "Publish Completed.";
localizations.share_email_sent = "Email message sent.";
localizations.share_open_in_email_client = "Open in Email Client";

//Custom form
localizations.loadingPageInFormFailedTitle = "Loading failed : ";

// Extensions/file types ready for preview using media plugin
window.mediaFileExtensions = ["3gp","3gpp","3g2","aif","aifc","aiff","asf","avi","flv", "gif", "m4v","mid","mov","mp2","mp3","mp4","ogg","webm","mpa","mpe","mpeg","mpg","mpv2","swf","wav","wmv"];

$(document).ready(function () {
    var iOS = navigator.userAgent.match(/(iPad|iPhone|iPod)/g) ? true : false;
    if(iOS)
        $("body").addClass("iOS");
	$(document).data("localizations", localizations); //sets localizations to cache
	if (!window.forSlideshow || !window.justReference) //If not slideshow only
	{
		delayInterval = 50;
		$.idleTimer(2000);
		$(document).bind("idle.idleTimer", function () {
			// function you want to fire when the user goes idle
			if (delayInterval != 500) {
				delayInterval = 500;
				clearInterval(window.hashListnerIntervalID);
				window.hashListnerIntervalID = window.setInterval(function () {
					try {
						hashListener.check();
					} catch (e) {}
				}, delayInterval);
			}
		});
		$(document).bind("active.idleTimer", function () {
			// function you want to fire when the user becomes active again
			if (delayInterval != 50) {
				delayInterval = 50;
				clearInterval(window.hashListnerIntervalID);
				window.hashListnerIntervalID = window.setInterval(function () {
					try {
						hashListener.check();
					} catch (e) {}
				}, delayInterval);
			}
		});
		//adds hash change listener
		clearInterval(window.hashListnerIntervalID);
		window.hashListnerIntervalID = window.setInterval(function () {
			try {
				hashListener.check();
			} catch (e) {}
		}, delayInterval);
	}
});
if (jQuery)(function ($) {
	$.extend($.fn, {
		fileTree: function (o, h) {
			// Defaults
			if (!o) var o = {};
			if (o.root == undefined) o.root = '/';
			if (o.folderEvent == undefined) o.folderEvent = 'click';
			if (o.thumbFolderEvent == undefined) o.thumbFolderEvent = 'dblclick';
			if (o.expandSpeed == undefined) o.expandSpeed = 500;
			if (o.collapseSpeed == undefined) o.collapseSpeed = 500;
			if (o.expandEasing == undefined) o.expandEasing = null;
			if (o.collapseEasing == undefined) o.collapseEasing = null;
			if (o.multiFolder == undefined) o.multiFolder = true;
			if (o.signupPage == undefined) o.signupPage = false;
			o.proxy = "/WebInterface/";
			o.proxy = o.proxy.substring(0, o.proxy.length - ("/Web" + "Interface/").length);
			o.ajaxCallURL = "/WebInterface/function/";
			o.uploadURL = "/WebInterface/function/";
			o.downloadURL = "/WebInterface/function/";
			o.ImageFilePath = "/WebInterface/jQuery/images/";
			o.FileExtensionImageFilePath = o.ImageFilePath + "fileExtensions/";
			o.FilePath = "/WebInterface/jQuery/";
			o.fileLarge = o.FileExtensionImageFilePath + "file";
			o.fileFolder = o.ImageFilePath + "folderLarge.png";
			o.fileFolder1 = o.ImageFilePath + "folderLarge1.png";
			o.fileFolder2 = o.ImageFilePath + "folderLarge2.png";
			o.fileFolder3 = o.ImageFilePath + "folderLarge3.png";
			o.spinerImage = o.ImageFilePath + "spinner.gif";
			o.PreviewIconThumbnailStyle = "border:0px;";
			//Various Cookies for layout
			o.ViewCookieName = "__WEBINTERFACE_FILE_LIST_VIEW";
			o.CookieHideItemStartingWithDot = "__WEBINTERFACE_HIDE_ITEMS_STARTING_WITH_DOT";
			o.CookieHideCheckBoxColumn = "__WEBINTERFACE_HIDE_CHECKBOX_COLUMN";
			o.CookieHideFilter = "__WEBINTERFACE_HIDE_FILTER";
			o.CookieAutoUploadFlag = "__WEBINTERFACE_FILE_AUTOUPLOAD";
			o.CookieAutoAppletFlag = "__WEBINTERFACE_AUTOAPPLET";
			o.CookieNoCompressionFlag = "__WEBINTERFACE_NOCOMPRESSION";
			o.CookieWelcomeNote = "__WEBINTERFACE_WELCOMENOTE";
			o.CookieCopiedFiles = "__WEBINTERFACE_FILES_COPIED";
			o.CookiePageSize = "__WEBINTERFACE_PAGE_SIZE";
			o.MaximumLengthAllowedForKeywordsString = 25;
			o.MaximumLengthAllowedForSharingPopupHeaderString = 50;
			o.thumbnailTextCharsLimit = 14;
			o.FileListingElement = $("#filesListing");
			o.MaxSimultaneousUploadAllowed = 1;
			o.GrowlTimeout = 3000; // If growl has close button (next option) it will be set to 0
			o.GrowlWithCloseButton = true;
			o.BasketDataKey = "__WEBINTERFACE_FILES_IN_BASKET";
			o.BasketDataKeyQuickDownload = "__WEBINTERFACE_FILES_IN_BASKET_QUICK_DOWNLOAD";
			o.lowestThumbnailBoxWidth = 110;
			o.lowestThumbnailBoxHeight = 140;
			o.buggyBrowser = $.browser.msie && $.browser.version <= 8;
			o.keywordsCharLimit = 1000;
			o.availableFileExtensionImages = ["ai", "avi", "bak", "bat", "bin", "bmp", "cab", "cmd", "css", "csv", "cue", "dat", "dic", "divx", "dll", "dmg", "doc", "docx", "dvd", "dwg", "exe", "file", "fla", "gif", "htm", "html", "ifo", "ini", "iso", "jpeg", "jpg", "js", "m4a", "mmf", "mov", "mp3", "mp4", "mpeg", "mpg", "otf", "pdf", "php", "png", "pps", "ppt", "pptx", "psd", "rar", "rtf", "swf", "sys", "tiff", "ttf", "txt", "vob", "wma", "wmv", "xls", "xlsx", "xml", "xmp", "zip", "sitx", "idml", "indd", "sit"]; /*Pagination options*/
			o.defaultPageSize = 100;
			o.pagingNumDisplayEntries = 10;
			o.pagingCurrentPage = 0;
			o.pagingNumEdgeEntries = 5;
			o.pagingControlsShowAlways = false; /*End :: Pagination options*/
			o.folderNameSpecialCharacterSubstitute = "_"; //While creating new folders, it will replace special characters with specified character
			// Template of file select panel
			o.browserTemplate = '<div class="uploadFormPanel" id="uploadDiv##">' + '<form id="META_uploadForm##" name="META_uploadForm##" action="' + o.uploadURL + '" enctype="multipart/form-data" method="post" target="iframeUploadSingle##">' + '<input id="uploadPath##" type="hidden" name="uploadPath" value="#DEST_PATH#" />' + '<input id="theName##" type="hidden" name="the_action" value="STOR" />' + '<input id="file_##_SINGLE_FILE_POST" type="file" multiple="" name="file_##_SINGLE_FILE_POST" />' + '</form>' + '<iframe name="iframeUploadSingle##" id="iframeUploadSingle##" src="javascript:false;" width="1" height="1" style="left:-5000px;display:none;">' + '</iframe>' + '</div>';
			//Column model for files XML
			o.colModel = [{
				name: 'type',
				index: 'type',
				sorttype: "text"
			}, {
				name: 'dateFormatted',
				index: 'dateFormatted',
				sorttype: "date"
			}, {
				name: 'date',
				index: 'date',
				sorttype: "date"
			}, {
				name: 'modified',
				index: 'modified',
				sorttype: "date"
			}, {
				name: 'size',
				index: 'size',
				sorttype: "number"
			}, {
				name: 'sizeFormatted',
				index: 'sizeFormatted',
				sorttype: "text"
			}, {
				name: 'name',
				index: 'name',
				sorttype: "text"
			}, {
				name: 'href_path',
				index: 'href_path',
				sorttype: "text"
			}, {
				name: 'keywords',
				index: 'keywords',
				sorttype: "text"
			}, {
				name: 'root_dir',
				index: 'root_dir',
				sorttype: "text"
			}, {
				name: 'preview',
				index: 'preview',
				sorttype: "text"
			}, {
				name: 'privs',
				index: 'privs',
				sorttype: "text"
			}];
			if (o.customData == undefined) o.customData = false;
			if (o.overrideFromHash == undefined)
			//It will load items  for particular folder as on hash location
			o.overrideFromHash = true;
			if (o.setHashLocation == undefined)
			//Enable or disable to set hash location on folder change
			o.setHashLocation = true;
			if (o.expandedImageURL == undefined)
			//Path to expanded image - displayed against expanded folder in a grid
			o.expandedImageURL = o.ImageFilePath + "expanded.png";
			if (o.collapsedImageURL == undefined)
			//Path to collapsed image - displayed against expanded folder in a grid
			o.collapsedImageURL = o.ImageFilePath + "collapsed.png";
			if (o.refreshImageURL == undefined)
			//Path to refresj image - displayed against current folder name in a breadcrumbs
			o.refreshImageURL = o.ImageFilePath + "refresh.png";
			$(this).each(function () {
				//Template for a header for Grid view
				var headerTemplate = "<thead><tr><td class='thSelect theader'><input type='checkBox' class='chkBoxAll' /></td><td colName='name' class='thName theader'>" + getLocalizationKey("TreeviewHeaderNameText") + "</td><td  colName='size' class='thSize theader'>" + getLocalizationKey("TreeviewHeaderSizeText") + "</td><td colName='modified' class='thModified theader'>" + getLocalizationKey("TreeviewHeaderModifiedText") + "</td><td colName='keywords' class='thKeywords theader'>" + getLocalizationKey("TreeviewHeaderKeywordsText") + "</td></tr></thead>";
				//Template for thumbnail view item
				var thumbnailItemTemplate = '<li class="vtip fileBox #CLASS#" index="#INDEX#" name="#NAME#" title="#TITLE#" privs="#PRIVS#" size="#SIZE#" fulldate="#FULLDATE#" Date="#DATE#" Keywords="#KEYWORDS#" preview="#PREVIEW#"><span class="fileSelectionMark"></span><div>' + '        <div class="imgBox"><div class="imgWrapper">' + '            <table cellspacing="0" cellpadding="0" align="center">' + '                <tbody>' + '                    <tr>' + '                        <td valign="middle" align="center">' + '                            <a class="imgLink" rel="#REL#" href="#HREF#">' + '                                <img alt="#NAME#" title="#NAME#" style="border: 0px none;" src="#SRC#">' + '                            </a>' + '                        </td>' + '                    </tr>' + '                </tbody>' + '            </table></div>' + '        </div>' + '    </div>' + '    <div class="imgTitle">' + '        <a  rel="#PATHREL#" href="#HREF#">#NAME#</a>' + '    </div>' + '</li>';
				/*
				 * Shows tree to particular elemenet. First parameter is
				 * parent element, t is a path. Locatefolder in treeview
				 * replaces all content with items in the folder specified.
				 * Usehash is a boolean, which overrides any path supplied
				 * and uses hash from location as a path
				 */

				 //Serialize form
				window.serializeForm = function (form) {
					if (!form || form.nodeName !== "FORM") {
						return "";
					}
					var i, j, q = [];
					for (i = form.elements.length - 1; i >= 0; i = i - 1) {
						if (form.elements[i].name === "") {
							continue;
						}
						switch (form.elements[i].nodeName.toUpperCase()) {
						case 'INPUT':
							switch (form.elements[i].type.toLowerCase()) {
							case 'text':
							case 'hidden':
							case 'password':
							case 'button':
							case 'reset':
							case 'submit':
								q.push(form.elements[i].name + "=" + crushFTPTools.encodeURILocal(form.elements[i].value));
								break;
							case 'checkbox':
							case 'radio':
								if (form.elements[i].checked && form.elements[i].value) {
									q.push(form.elements[i].name + "=" + crushFTPTools.encodeURILocal(form.elements[i].value));
								}
								break;
							case 'file':
								break;
							}
							break;
						case 'TEXTAREA':
							q.push(form.elements[i].name + "=" + crushFTPTools.encodeURILocal(form.elements[i].value));
							break;
						case 'SELECT':
							switch (form.elements[i].type) {
							case 'select-one':
								q.push(form.elements[i].name + "=" + crushFTPTools.encodeURILocal(
								$("#" + form.elements[i].id).val()));
								break;
							case 'select-multiple':
								for (j = form.elements[i].options.length - 1; j >= 0; j = j - 1) {
									if (form.elements[i].options[j].selected) {
										q.push(form.elements[i].name + "=" + crushFTPTools.encodeURILocal(form.elements[i].options[j].value));
									}
								}
								break;
							}
							break;
						case 'BUTTON':
							switch (form.elements[i].type) {
							case 'reset':
							case 'submit':
							case 'button':
								q.push(form.elements[i].name + "=" + crushFTPTools.encodeURILocal(form.elements[i].value));
								break;
							}
							break;
						}
					}
					return q.join("&");
				}

				window.IE = function (obj) {
                    if ($.browser.msie && parseInt(jQuery.browser.version) == 10) {
                        var itm = {};
                        itm.textContent = $(obj).text();
                        return itm;
                    }
                    else
                    {
    					if (window.ActiveXObject) {
    						var obj2 = {};
    						try {
    							obj2.textContent = obj.text;
    						} catch (ex) {}
    						return obj2;
    					} else {
    						return obj;
    					}
                    }
				}

                //Disable or hide the fields on custom page based on their name
                window.setCustomFormFieldAttributes = function(panel)
                {
                    $(panel).find("*[name$='_disabled']").attr("disabled", "disabled");
                    $(panel).find("*[name$='_readonly']").attr("readonly", "readonly");
                    $(panel).find("*[name$='_hidden']").each(function(){
                        $(this).closest("tr").hide();
                    });
                    $(panel).find("*[name*='password']").each(function(){
                        try{
                            $(this).get(0).type='password';}
                        catch(ex){}
                    });
                    setTimeout(function(){
                        $(panel).find("input[name$='_db']").each(function(){
                            var formName = $(this).closest("form").find("#meta_form_name").val();
                            var elemName = $(this).attr("name");
                            if(!$(this).data("autoCompleteAdded"))
                            {
                                $(this).tokenInput("/WebInterface/function/?command=lookup_form_field&form_name="+formName+"&form_element_name=" + elemName, {
                                    theme : "facebook",
                                    preventDuplicates : true,
                                    onResult: function (results, val) {
                                        if(results && results.length==0 && val)
                                        {
                                            results = [{"id":val,"name":val}];
                                        }
                                        return results;
                                    }
                                });
                                $(this).data("autoCompleteAdded", true);
                            }
                        });
                    }, 500);
                    $(panel).find(".loadPage").each(function(){
                        var page = $(this).attr("page");
                        if(page)
                        {
                            var that = $(this).empty().append($("<div>"));
                            that = that.find("div");
                            if(page.indexOf("#")>0)
                            {
                                var _index = page.indexOf("#");
                                var style = page.substring(page.indexOf("#") + 1, page.length);
                                that.attr("style", style);
                            }
                            that.css("overflow", "auto");
                            that.text("Wait..");
                            that.load(page, function(response, status, xhr){
                                if (status == "error") {
                                    that.text(getLocalizationKey("loadingPageInFormFailedTitle") + page);
                                }
                            });
                        }
                    });

                    setTimeout(function(){
                        $(panel).find("select[name$='_cascade']").each(function(){
                            var _this = $(this);
                            _this.bind("change", function(){
                                var val = $(this).val();
                                _this.find("option").each(function(){
                                    $(panel).find("*[name$='_"+$(this).val()+"']").closest("tr").hide();
                                });
                                $(panel).find("*[name$='_"+val+"']").closest("tr").show();
                            }).trigger("change");
                        });
                    }, 500);
                    $(panel).find("input").each(function(){
                        var name = $(this).attr("name");
                        if(panel.find("input[name='"+name+"2']").length>0)
                        {
                            $(this).addClass("validatePasswords");
                            panel.find("input[name='"+name+"2']").addClass("validatePasswords");
                        }
                        if(name && name.indexOf("verify")>=0)
                        {
                            var origElem;
                            if(name.indexOf("_verify_")>=0 || name.indexOf("_verify")>=0)
                                origElem = name.replace("_verify", "");
                            else if(name.indexOf("verify_")>=0)
                                origElem = name.replace("verify_", "");
                            if(origElem)
                            {
                                panel.find("input[name='"+origElem+"']").addClass("validateSameValue").attr("compareWith", name);
                            }
                        }
                    });
                }

                //Attach calendar to date fields
                window.attachCalendarPopup = function(panel) {
                    var _nowDate = new Date();
                    _nowDate.setDate(_nowDate.getDate() + 1);
                    var _dateFormat = 'mm/dd/yy';
                    if (window.CustomFormyyyymmdd) { //Choose custom date format
                        _dateFormat = 'yy/MM/dd';
                    }
                    panel.find("input.futureDateField").each(function(){
                        if($(this).is(":disabled") || $(this).attr("readonly")) return;
                        $(this).datepicker({ //For date fields which accepts future dates
                            dateFormat: _dateFormat,
                            showOn: 'both',
                            buttonImage: '/WebInterface/jQuery/images/calendar.png',
                            buttonImageOnly: true,
                            minDate: _nowDate
                        }).attr("readonly", "readonly");
                    });

                    panel.find("input.dateField").each(function(){
                        if($(this).is(":disabled") || $(this).attr("readonly")) return;
                        $(this).datepicker({  //Normal date fields
                            dateFormat: _dateFormat,
                            showOn: 'both',
                            buttonImage: '/WebInterface/jQuery/images/calendar.png',
                            buttonImageOnly: true
                        }).attr("readonly", "readonly");
                    });
                }

                //Hash listener plugin
                window.hashListener = {
                    ie: /MSIE/.test(navigator.userAgent),
                    ieSupportBack: true,
                    hash: document.location.hash,
                    check: function () {
                        var h = document.location.hash;
                        if (h != this.hash) {
                            this.hash = h;
                            this.onHashChanged();
                        }
                    },
                    init: function () {
                        if (this.ie && this.ieSupportBack) {
                            var frame = document.createElement("iframe");
                            frame.id = "state-frame";
                            frame.style.display = "none";
                            if (document.body) {
                                document.body.appendChild(frame);
                                this.writeFrame("");
                            }
                        }
                        var self = this;
                        if ("onpropertychange" in document && "attachEvent" in document) {
                            document.attachEvent("onpropertychange", function () {
                                if (event.propertyName == "location") {
                                    self.check();
                                }
                            });
                        }
                    },
                    setHash: function (s) {
                        if (this.ie && this.ieSupportBack) {
                            this.writeFrame(s);
                        }
                        document.location.hash = s;
                        if (document.location.hash != ("#" + s)) document.location.hash = crushFTPTools.encodeURILocal(s); //fix for Firefox refusing some strings...umlauts
                    },
                    getHash: function () {
                        return document.location.hash;
                    },
                    writeFrame: function (s) {
                    },
                    syncHash: function () {
                        var s = this._hash;
                        if (s != document.location.hash) {
                            document.location.hash = s;
                        }
                    },
                    onHashChanged: function () {
                        var t = escape(unescape(this.getHash().replace("#", "")));
                        var loc = unescape(t);
                        if(loc.lastIndexOf("/")!=loc.length-1)
                        {
                            t = loc + "/";
                            setHashLocation(escape(unescape(t)));
                            return;
                        }
                        window.current_page = o.pagingCurrentPage = 0;
                        if (currentView() == "Thumbnail") {
                            showTree($("#filesContainerDiv"), t, true);
                        } else {
                            showTree($("#filesContainer"), t, true);
                        }
                    }
                };
                hashListener.init();

				if (o.signupPage) // If to display sign-up form
				{
					// function to retrive current page's name
					function GetCurrentPageName() {
						var sPath = window.location.pathname;
						var sPage = sPath.substring(sPath.lastIndexOf("/") + 1);
						return sPage;
					}
					var customFormName = GetCurrentPageName();
					customFormName = customFormName.replace(".html", "");
					// Get custom form from server and display
					getCustomForm(customFormName, function (data, hasForm, formName, showAlways) {
						if (hasForm) {
							var signupPanel = $("#panelSignup");
							signupPanel.html("<form id='frmSignup' method='post' target='dummyIframe' action='/WebInterface/function/?command=discard'>" + data + "</form>").find("table").css("text-align", "left");
							setCustomFormFieldAttributes(signupPanel)
							attachCalendarPopup(signupPanel);
							$("button#resetPasteForm", signupPanel).unbind().click(function (event) {
								signupPanel.clearForm();
								event.stopPropagation();
								event.preventDefault();
							});
							signupPanel.find("input").keydown(function (evt) {
								var evt = (evt) ? evt : ((event) ? event : null);
								if (evt.keyCode == 13) {
									$("button.submitForm", signupPanel).click();
									return false;
								} else if (evt.keyCode == 27) {
									$("button#resetPasteForm", signupPanel).click();
									return false;
								}
							});
							// a method to show error on signup page
							function displayError(msg, isSuccess) {
								var form = signupPanel;
								if (form.prev().hasClass("attention")) {
									form.prev().remove();
								}
                                if(isSuccess)
                                {
                                    form.before("<div style='float: none;border: solid 1px #CCC;-moz-box-shadow: 2px 1px 3px #CCC;-webkit-box-shadow: 2px 1px 3px #CCC;box-shadow: 2px 1px 3px #CCC;background-color: #FEFFD3;padding: 18px;'><h3 style='background-image: url(/WebInterface/jQuery/images/checkmark.png);background-position: left 1px;background-repeat: no-repeat;padding-left:20px;'>Registration completed : </h3><br> <div style='padding-left:20px;'> "+localizations.RegisterWindowProcessCompleteMessage+" <br><br><br> <a style='color:black;' href='javascript:window.location.reload();'>Register Another User</a> | <a  style='color:black;' href='/WebInterface/login.html'>Login</a></div></div>");
                                }
                                else
                                {
								    form.before("<div class='attention' style='float: none;border: solid 1px #CCC;-moz-box-shadow: 2px 1px 3px #CCC;-webkit-box-shadow: 2px 1px 3px #CCC;box-shadow: 2px 1px 3px #CCC;background-color: #FEFFD3;padding: 10px;'><h3 style='padding-left:20px;'>"+msg+" : </h3><br> <div style='padding-left:20px;'><strong>Few reasons why registration can fail : </strong><br><br>- The username is already in use. <br> - Server is temporarily not allowing registrations.  <br><br> Please try again, or contact your administrator.</div></div>");
                                }
								form.prev().css("float", "none");
							}
							//Check if input has special characters
							function hasSpecialCharacters(input, charset){
								charset = charset || "&:/\;<>?+=%#";
								for (var i = 0; i < input.length; i++) {
									if (charset.indexOf(input.charAt(i)) != -1) {
										return true;
									}
								}
								return false;
							}

							// a method to validate signup form
							function validateForm(target, form) {
								form = form || $("table.customForm", "#divUploadPanel");
								form.find("input[name='meta_registration_username']").addClass("validateUserName");
								var validated = true;
								form.find(".required_true:visible, .validateEmail, .validateUserName, .validatePasswords, .validateSameValue").each(
								function () {
                                    var ignoreRdOnly = $(this).hasClass("futureDateField") || $(this).hasClass("dateField");
                                    if(!ignoreRdOnly)
									   if($(this).is(":disabled") || $(this).attr("readonly")) return;
									if ($(this).hasClass("chkbox")) {
										if (!$(this).is(":checked") && $(this).closest("td").find("input:checked").length == 0) {
											$(this).parent().addClass("validationFail");
											if (validated) {
												$(this).parent().focus();
											}
											validated = false;
										} else {
											$(this).parent().removeClass("validationFail");
										}
									} else {
										if ($.trim($(this).val()).length == 0 && $(this).hasClass("required_true")) {
											$(this).addClass("validationFail");
											if (validated) {
												$(this).focus();
											}
											validated = false;
										}
										else if($(this).hasClass("validateUserName") && hasSpecialCharacters($(this).val()))
										{
											$(this).addClass("validationFail");
											if (validated) {
												$(this).focus();
											}
											$(this).after("<span class='attention' style='float:none;position:absolute;margin:0px;'>User name can not contain these characters : & : / \ ; < > ? + = % # </span>");
											validated = false;
										}
										else {
											$(this).parent().find(".attention").remove();
											if($(this).hasClass("validateEmail"))
											{
												if ($.trim($(this).val()).length > 0 && !validateEmail($(this).val(), true)) {
													$(this).addClass("validationFail emailFail");
													if (validated) {
														$(this).focus();
													}
													validated = false;
												}
												else if($(this).hasClass("emailFail"))
												{
													$(this).removeClass("validationFail emailFail");
												}
											}
                                            else if($(this).hasClass("validatePasswords"))
                                            {
                                                var nextPass = form.find("input[name='"+$(this).attr("name")+"2']");
                                                if(nextPass.length>0)
                                                {
                                                    if ($.trim($(this).val()) != $.trim($(nextPass).val())) {
                                                        $(this).addClass("validationFail passMatchFail");
                                                        nextPass.addClass("validationFail passMatchFail");
                                                        $(this).parent().find(".passwordDsntMatch").remove();
                                                        $(this).after("<span class='requiredField passwordDsntMatch' style='float:none;'> "+getLocalizationKey("customFormPasswordMatchValidationFailedText")+"</span>");
                                                        if (validated) {
                                                            $(this).focus();
                                                        }
                                                        validated = false;
                                                    }
                                                    else if($(this).hasClass("emailFail") || $(this).hasClass("passMatchFail") || $(this).hasClass("matchFail"))
                                                    {
                                                        $(this).removeClass("validationFail passMatchFail");
                                                        nextPass.removeClass("validationFail passMatchFail");
                                                        form.find(".passwordDsntMatch").remove();
                                                    }
                                                    else if($(this).hasClass("required_true") && $(this).val().length>0)
                                                    {
                                                        $(this).removeClass("validationFail");
                                                    }
                                                }
                                            }
											else
											{
												$(this).removeClass("validationFail");
											}
                                            if($(this).hasClass("validateSameValue"))
                                            {
                                                var compareWith = form.find("input[name='"+$(this).attr("compareWith")+"']");
                                                if(compareWith.length>0)
                                                {
                                                    if ($.trim($(this).val()) != $.trim($(compareWith).val())) {
                                                        $(this).addClass("validationFail matchFail");
                                                        compareWith.addClass("validationFail matchFail");
                                                        $(this).parent().find(".valueDsntMatch").remove();
                                                        $(this).after("<span class='requiredField valueDsntMatch' style='float:none;'> "+getLocalizationKey("customFormCompareValueMatchValidationFailedText")+"</span>");
                                                        if (validated) {
                                                            $(this).focus();
                                                        }
                                                        validated = false;
                                                    }
                                                    else if($(this).hasClass("matchFail"))
                                                    {
                                                        $(this).removeClass("validationFail matchFail");
                                                        compareWith.removeClass("validationFail matchFail");
                                                        form.find(".valueDsntMatch").remove();
                                                    }
                                                    else if($(this).hasClass("required_true") && $(this).val().length>0)
                                                    {
                                                        $(this).removeClass("validationFail");
                                                    }
                                                }
                                            }
										}
									}
								});
								if (form.prev().hasClass("attention")) {
									form.prev().remove();
								}
								if (!validated) {
									form.before("<div class='attention'>" + getLocalizationKey("FormValidationFailText") + "</div>");
									if(form.find(".emailFail").length>0)
									{
										form.prev().append("<div>" + getLocalizationKey("FormEmailValidationFailText") + "</div>");
									}
								}
                                else
                                {
                                    form.find(".passwordDsntMatch").remove();
                                }
								return validated;
							}
							// signup window submit form
							$("button.submitForm", signupPanel).unbind().click(function (event) {
								signupPanel.find("form").submit();
								event.stopPropagation();
								event.preventDefault();
								if (!validateForm("", $("#panelSignup"))) {
									return;
								}
								var messageForm = $("#panelSignup");
								var formClone = messageForm.find("form");
								messageForm = serializeForm(formClone[0]);
								if (messageForm.length == 0) {
									return;
								}
								messageForm += "&command=selfRegistration&random=" + Math.random();
								var obj = messageForm;
								$("#panelSignup").addClass("spinner");
								$.ajax({
									type: "POST",
									url: o.ajaxCallURL,
									data: obj,
									error: function (XMLHttpRequest, textStatus, errorThrown) {
										errorThrown = errorThrown || messageForm;
										displayError("Error : " + errorThrown);
									},
									success: function (msg) {
										$("#panelSignup").removeClass("spinner");
										var responseText = msg;
										var response = msg.getElementsByTagName("response");
										response = IE(response[0]).textContent;
										if (response.toLowerCase() == "success") {
											$("#panelSignup").hide();
										    displayError(response, true);
                                        }
                                        else
                                            displayError(response);
									}
								});
								return false;
							});
						}
					}, "Sign up");
                    bindUserCustomizationInfo();
					return;
				}

				function showTree(parentElement, path, locateFolder, useHash, callback) {
                    function continueListingLoad()
                    {
    					parentElement = $(parentElement);
    					parentElement.addClass('wait'); /* Remove initial element */
    					$("#searchResultNotification").hide();
    					$(".jqueryFileTree.start").remove(); /* If to use custom data - Specific to CrushFTP */
    					if (o.customData) { /* Conditions if overrid location to use from location hash*/
    						if ((!$(this).data("initialized") && o.overrideFromHash) || useHash) {
    							$(this).data("initialized", true);
    							var hashLocation = getHash().replace("#", "");
    							if (hashLocation) {
    								path = hashLocation;
    							} else {
    								path = "/";
    							}
    						}
    						/* If nothing specified use root directory */
    						if (path.length == 0 || path == 'null') path = "/"; /* Data to POST to receive file listing */
    						if (window.redirectRoot && path == "/") document.location = window.redirectRoot;
    						if(path.lastIndexOf("/")!=path.length-1)
    						{
    							var ext = getFileExtension(path);
    							if(ext && ext.length>0)
    							{
    								downloadItems(false, false, path);
    							}
    						}
    						$("div.mainNavigation").block({
    							message: "",
    							css: {
    								border: 'none',
    								color: '#000'
    							}
    						});
                            var loadingIndicator = $("#loadingIndicator").text(getLocalizationKey("loadingIndicatorText"));//.dialog('option', 'title', 'Loading');
                            loadingIndicator.dialog('open');
                            var _path = ""
                            try{
                                _path = crushFTPTools.decodeURILocal(path);
                                _path = crushFTPTools.encodeURILocal(unescape(unescape(path)));
                            }
                            catch(ex)
                            {
                                _path = crushFTPTools.encodeURILocal(path);
                            }
    						var obj = {
    							command: "getXMLListing",
    							format: "JSONOBJ",
    							path: _path,
    							random: Math.random()
    						};

                            /* Make a call and receive list */
    						$.ajax({
    							type: "POST",
    							url: o.ajaxCallURL,
    							data: obj,
                                async: true,
                                dataType: "json",
                                beforeSend: function(x) {
                                    if(x && x.overrideMimeType) {
                                        x.overrideMimeType("application/j-son;charset=UTF-8");
                                    }
                                },
    							success: function (data) {
                                    loadingIndicator.dialog('close');
                                    var msg = data.listing;
                                    window.l = msg;
    								if ($(document).data("uploadOnly")) {
    									window.curTreeItems = window.curTreeItems ? window.curTreeItems : window.l ? window.l : {};
                                        var privs = data.privs;
                                        $(document).data("folderPrivs", privs);
    									return false;
    								}
                                    var inverse = true;
                                    if (window.listingSortColumn) {
                                        if (window.listingSortDirection == "up") {
                                            inverse = false;
                                        }
                                    }
                                    if(!locateFolder && parentElement.hasClass('directory'))
                                    {
    								    renderListing(parentElement, locateFolder, useHash, data);
                                    }
                                    else
                                    {
                                        sortListing(false, false, true, true);
                                        data.listing = window.l;
                                        renderListing(parentElement, locateFolder, useHash, data);
                                    }
    								if(l) {
    									var privs = data.privs;
    									$(document).data("curDirPrivs", privs);
    									applyPrivs();
    									//its a reference to a file and not a folder, so do a download of it.
    									if (currentView() == "Thumbnail") {
    										if (!parentElement.hasClass("directory") && parentElement.find("a.imgLink[href='" + escape(unescape(path)) + "']")[0] && parentElement.find("a.imgLink[href='" + escape(unescape(path)) + "']").length == 1) {
    											downloadItems(false, parentElement.find("a[rel='" + escape(unescape(path)) + "']").closest("td"));
    											renderListing(parentElement, locateFolder, useHash, null); //empty the listing.
    										}
    									} else {
    										if (!parentElement.is("table#filesContainer") && !parentElement.hasClass("directory") && parentElement.find("a[rel='" + escape(unescape(path)) + "']")[0] && parentElement.find("a[rel='" + escape(unescape(path)) + "']").length == 1) {
    											downloadItems(false, parentElement.find("a[rel='" + escape(unescape(path)) + "']").closest("td"));
    											renderListing(parentElement, locateFolder, useHash, null); //empty the listing.
    										}
    									}
    									showItemsBasedOnData(true, obj);
    								}
    								else
    								{
    									showItemsBasedOnData(false, obj);
    								}
    								if (callback) {
    									try {
    										callback();
    									} catch (ex) {
                                        }
    								}
                                    blockFileListingUI(false);
    							},
    							error: function (XMLHttpRequest, textStatus, errorThrown) {
    								//its a reference to a file or folder as zip, so start a zip on demand of it.
    								if (path.lastIndexOf(".zip") == path.length - 4) {
    									path = path.substring(0, path.lastIndexOf(".zip"));
    									submitAction({
    										'#command': "downloadAsZip",
    										'#path': crushFTPTools.encodeURILocal("/"),
    										'#paths': crushFTPTools.encodeURILocal(unescape(path)),
    										'#random': Math.random()
    									});
    								} else {
    									errorThrown = errorThrown || "getXMLListing failed";
    									$.growlUI("Error : " + errorThrown, errorThrown, o.GrowlTimeout, "", o.GrowlWithCloseButton);
    									showItemsBasedOnData(false, obj);
    								}
    								if (!$(document).data("uploadOnly")) {
    									renderListing(parentElement, locateFolder, useHash, null); //empty the listing.
    								} else {
    									window.curTreeItems = window.curTreeItems ? window.curTreeItems : window.l ? window.l : {};
    								}
                                    blockFileListingUI(false);
                                    loadingIndicator.dialog('close');
    							}
    						});
    					} else {
    						$.post(o.script, {
    							dir: path
    						}, function (data) {
    							parentElement.find('.start').html('');
    							parentElement.removeClass('wait').append(data);
    							blockFileListingUI(false);
    							parentElement.find('TR:hidden').show();
    							bindTree(parentElement);
    							if (callback) {
    								try {
    									callback();
    								} catch (ex) {}
    							}
    						});
    					}
                    }
                    if(window.listingHTMLPage)
                    {
                        if(!$.CrushFTP.DNDAdded)
                        {
                            $.CrushFTP.attachDND(o);
                            $.CrushFTP.DNDAdded = true;
                        }
                        showDirListingFile(function(){
                            continueListingLoad();
                        });
                    }
                    else
                        continueListingLoad();
				}

				//Function to manage items on screen based on folder loaded
				function showItemsBasedOnData(folderLoaded, obj)
				{
					if(!folderLoaded)
					{
						$.growlUI(getLocalizationKey("NoFilesFoundGrowlTitle"), "<span class='nodataFoundErrorMsg'></span>" + getLocalizationKey("NoFilesFoundGrowlText") + crushFTPTools.decodeURILocal(obj.path), o.GrowlTimeout, "", o.GrowlWithCloseButton);
					}
					else
					{
						$(".nodataFoundErrorMsg").closest("div.blockUI").find("img.closeButton").trigger("click");
					}
				}

				// method shows/hides menu items based on privs of current logged in user.
				function applyPrivs() {
					var privs = $(document).data("curDirPrivs");
                    if(!privs)
                        return;
					var _delete = privs.indexOf("(delete)") >= 0;
					var _write = privs.indexOf("(write)") >= 0;
					var _resume = privs.indexOf("(resume)") >= 0;
					var _share = privs.indexOf("(share)") >= 0;
					var _slideshow = privs.indexOf("(slideshow)") >= 0;
					var _rename = privs.indexOf("(rename)") >= 0;
					var _makedir = privs.indexOf("(makedir)") >= 0;
					var _deleteDir = privs.indexOf("(deletedir)") >= 0;
					var _download = privs.indexOf("(read)") >= 0;
					var myMenu = $("#mainNavigation");
					myMenu.find("a[href*='changeIcon']").parent().hide();
					if (!_delete) {
						myMenu.find("a[href='javascript:delete_items();']").remove();
					}
					if(!_write)
					{
						myMenu.find("a[href='javascript:performAction('cut');']").remove();
						myMenu.find("a[href='javascript:performAction('copy');']").remove();
						myMenu.find("a[href='javascript:performAction('paste');']").remove();
						myMenu.find("a[href*='updateKeywords']").parent().hide();
                        $("#fileQueueInfo").hide();
					}
                    else
                        $("#fileQueueInfo").show();
					if (!_makedir) {
						myMenu.find("a[href='javascript:performAction('createFolder');']").remove();
					}
					if (!_slideshow) {
						myMenu.find("a[href='javascript:performAction('slideshowDiv');']").remove();
						myMenu.find("a[href='javascript:performAction('Preview');']").remove();
					}
					if (!_download) {
						myMenu.find("a[href='javascript:performAction('download');']").remove();
						myMenu.find("a[href='javascript:performAction('cut');']").remove();
						myMenu.find("a[href='javascript:performAction('copy');']").remove();
						myMenu.find("a[href='javascript:performAction('paste');']").remove();
					}
				}

				// To preserve location of browser scroll
				function scrollToFileListing() {
					if ($('html,body').scrollTop() > $("#mainContent").offset().top) {
						$('html,body').animate({
							scrollTop: $("#mainContent").offset().top
						}, 0, false);
					}
				}

				//Back to top link event
				function bindBackToTop() {
					$(".backToTop").click(function () {
						$('html,body').animate({
							scrollTop: 0
						}, 500, false);
					});
				}
				var delay = (function () {
					var timer = 0;
					return function (callback, ms) {
						clearTimeout(timer);
						timer = setTimeout(callback, ms);
					};
				})();

				// Sorting method for item listing
				function sortListing(column, dir, rebuild, isInit) {
                    if(window.listingPageShown)return;
                    if(isInit && !$(document).data("listDefaultSortColumnIndex"))
                    {
                        if(window.l)
                        {
                            var dirItems = [];
                            var fileItems = [];
                            for(var i=0;i<window.l.length;i++)
                            {
                                var type = window.l[i].type;
                                if(typeof type != "undefined" && type == "DIR")
                                    dirItems.push(window.l[i]);
                                else
                                    fileItems.push(window.l[i]);
                            }
                            dirItems.sort(function(a, b) {
                              if (a.name.toLowerCase() < b.name.toLowerCase()) { return -1; }
                              if (a.name.toLowerCase() > b.name.toLowerCase()) { return  1; }
                              return 0;
                            });

                            fileItems.sort(function(a, b) {
                              if (a.name.toLowerCase() < b.name.toLowerCase()) { return -1; }
                              if (a.name.toLowerCase() > b.name.toLowerCase()) { return  1; }
                              return 0;
                            });
                            window.l = dirItems.concat(fileItems);
                        }
                        if (window.filteredItems && window.last_search_item && window.last_search_item.length>0) {
                            if (rebuild) {
                                filterItem(window.last_search_item, true);
                            }
                        } else {
                            if (rebuild) {
                                reBuildListing();
                            }
                        }
                    }
                    else
                    {
    					if (!column) {
    						if (window.listingSortColumn) {
    							column = window.listingSortColumn;
    						}
    					}
    					window.listingSortDirection = dir;
    					window.listingSortColumn = column;
    					var inverse = window.listingSortDirection;

    					function IsNumeric(input) {
    						return !((input - 0) == input && input.length > 0);
    					}

    					function applySorting(x, y) {
    						if(x && x[window.listingSortColumn] && y && y[window.listingSortColumn])
    						{
    							var a = x[window.listingSortColumn].toLowerCase();
    							var b = y[window.listingSortColumn].toLowerCase();
    							return (IsNumeric(a) || IsNumeric(b) ? a > b : +a > +b) ? inverse ? -1 : 1 : inverse ? 1 : -1;
    						}
    						else
    							return inverse ? 1 : -1;
    					}
                        if(window.l)
                            l = l.sort(applySorting);
                        if (window.filteredItems && window.last_search_item && window.last_search_item.length>0) {
    						if (rebuild) {
    							filterItem(window.last_search_item, true);
    						}
                        } else {
    						if (rebuild) {
    							reBuildListing();
    						}
    					}
                    }
				}

				// Sorting method for item listing
				function sortBasketListing(column, dir, rebuild) {
					if (!column) {
						if (window.listingSortColumnBasket) {
							column = window.listingSortColumnBasket;
						}
					}
					window.listingSortDirectionBasket = dir;
					window.listingSortColumnBasket = column;
					var inverse = window.listingSortDirectionBasket;

					function IsNumeric(input) {
						return !((input - 0) == input && input.length > 0);
					}

					function applySorting(x, y) {
						if(x && x[window.listingSortColumnBasket] && y && y[window.listingSortColumnBasket])
						{
							var a = x[window.listingSortColumnBasket].toLowerCase();
							var b = y[window.listingSortColumnBasket].toLowerCase();
							return (IsNumeric(a) || IsNumeric(b) ? a > b : +a > +b) ? inverse ? -1 : 1 : inverse ? 1 : -1;
						}
						else
							return inverse ? 1 : -1;
					}
					var ItemsInTheBasket = $(document).data(o.BasketDataKey);
					if(ItemsInTheBasket)
					{
						ItemsInTheBasket = ItemsInTheBasket.sort(applySorting);
					}
					$(document).data(o.BasketDataKey, ItemsInTheBasket);
					if (rebuild) {
						rebuildBasket();
					}
				}

                function sortToDefaultsIfAvailable()
                {
                    if($(document).data("listDefaultSortColumnIndex"))
                    {
                        setTimeout(function(){
                            if (window.listingSortColumn) {
                            var inverse = true;
                            if (window.listingSortDirection == "up") {
                                    inverse = false;
                                }
                            }
                            sortListing(window.listingSortColumn, inverse, true);
                        }, 100);
                    }
                }

				//Renders list of items
				function renderListing(parentElement, locateFolder, useHash, responseData, searchResult) {
					$("#filter").val(""); // reset user filter
					parentElement = $(parentElement);
					if (searchResult) { // if it is a search result
						$("#searchResultNotification").show();
					}
					if (!$("#filter").data("eventAdded")) // bind event of keyup on filter input to do live filter if event not added already
					{
                        if(window.useFilterForSearch)
                        {
                            $("#filter").unbind("keyup").keyup(function (evt) {
                                var evt = (evt) ? evt : ((event) ? event : null);
                                var val = this.value;
                                function startFilter() {
                                    setTimeout(function () {
                                        $("#keyword").val(val);
                                        startSearch(val);
                                    }, 10);
                                }
                                if (evt.keyCode == 13) {
                                    startFilter();
                                } else {
                                    delay(function () {
                                        startFilter();
                                    }, 700);
                                }
                            }).data("eventAdded", true);
                        }
                        else
                        {
    						$("#filter").unbind("keyup").keyup(function (evt) {
    							var evt = (evt) ? evt : ((event) ? event : null);
    							var val = this.value;

    							function startFilter() {
    								if (window.last_search_item && window.last_search_item === val) { // if value is not updated, do nothing
    									return false;
    								}
    								$("#itemCount").prepend("<span style='margin-right:15px;color:#777;'>(Applying filter...)</span>");
    								setTimeout(function () {
    									filterItem(val);
    								}, 10);
    							}
    							if (evt.keyCode == 13) {
    								startFilter();
    							} else {
    								delay(function () {
    									startFilter();
    								}, 1000);
    							}
    						}).data("eventAdded", true);
                        }
					}
					$("#cluetip").hide(); // remove tooltip shown
					//If current view is thumbnail
					if (currentView() == "Thumbnail") {
						//This will provide HTML for thumbnails
                        sortToDefaultsIfAvailable();
                        var data = mapXmlToTable(responseData, true);
                        parentElement.html(data);
						prepareDataRow(parentElement.find("li"));
						bindTree();
						bindAllEventsForThumbnailView(parentElement, data);
						$("#slider").show();
						scrollToFileListing();
					} else { /* If its tree view */
						if (!$("table#filesContainer").data("columnsAdded")) {
							$("table#filesContainer").find('.start').html('');
							$("table#filesContainer").removeClass('wait').append("<tbody></tbody>").prepend(headerTemplate);
							$("table#filesContainer").data("columnsAdded", true);
						}
						if (searchResult) { // Displaying result from search query
							$(document).data("expandedFolders", []);
							scrollToFileListing();
							//Get the html after XML parsing for treeview
							var data = mapXmlToTable(responseData, true);
							//Remove old items
							parentElement.find(".headerSortDown").removeClass("headerSortDown");
							parentElement.find(".headerSortUp").removeClass("headerSortUp");
							parentElement.find("tbody").html('');
							//Remove spinner and add HTML
							parentElement.find("tbody").append(data);
							//Display new items
                            var elems = parentElement.find('TR:hidden:not(.hiddenFile)').show().addClass("subdirectory"); /* Bind various events */
                            prepareDataRow(parentElement.find("tr"));
                            bindTree(elems);
							blockFileListingUI(false);
							//Apply proper padding and make it look like Tree
							var nameColumns = $(elems).find('.columnName');
							nameColumns.addClass("subdirectory");
							nameColumns.last().parent().addClass("subdirectoryLast");
							var relLink = $("a[rel='" + $(nameColumns).first().parent().attr("rel") + "']");
							var dirCheckBox = $(relLink).closest("tr").find(".chkBox:visible"); /* Handle checkboxes */
							checkUnCheckDirectory(dirCheckBox.parent(), dirCheckBox.is(":checked"));
							toggleMainCheckbox(dirCheckBox.closest("table"));
							var padLeft = 0;
							if (relLink.parent().css("padding-left")) {
								try {
									padLeft = parseInt(relLink.parent().css("padding-left").replace("px", ""));
								} catch (ex) {}
							} else {
								padLeft = 20;
							}
							if (padLeft != NaN) {
								if (padLeft >= 20) {
									padLeft += 20;
									var padicon = padLeft;
									var padTree = padicon - 20;
									nameColumns.attr("style", "padding-left:" + padLeft + "px !important;");
								}
							}
							bindAllEventsForTreeviewGrid(parentElement, true, data);
                            sortToDefaultsIfAvailable();
						} else if (!locateFolder && parentElement.hasClass('directory')) {
							//If  to  show folder items  under  tree
							//Get the html after XML parsing for treeview
							var data = mapXmlToTable(responseData, true, true, parentElement);
							//Remove old items
							var $parent = parentElement.closest('table') || $parent;
							$parent.find(".headerSortDown").removeClass("headerSortDown");
							$parent.find(".headerSortUp").removeClass("headerSortUp");
							$parent.find("tbody").empty();
							$parent.append(data).find('TR:hidden').show();
							//Select and create an array of folders that are expanded
							var expandedFolder = parentElement.find("a").attr("rel");
							var expandedFolders = $(document).data("expandedFolders");
							if (!expandedFolders) {
								expandedFolders = [];
							}
							if (!expandedFolders.has(expandedFolder)) {
								expandedFolders.push(expandedFolder);
							}
							$(document).data("expandedFolders", expandedFolders);
							// Cache it for later use
							/*if (!o.buggyBrowser && $("span[rel='" + expandedFolder + "']:first").length > 0) {
								var spanTop = $("span[rel='" + expandedFolder + "']:first").offset().top;
                                if ($('html,body').scrollTop() < spanTop) {
                                    $('html,body').scrollTop(spanTop);
                                }
                                setTimeout(
                                    function(){
                                        var mainNavigation = $("#mainNavigation");
                                        var spanTop = $("span[rel='" + expandedFolder + "']:first").offset().top;
                                        var adjust = $("#filesContainer").offset().top - $(".breadCrumbsPanel:first").offset().top;
                                        if(mainNavigation.hasClass("stick"))
                                            spanTop = spanTop + mainNavigation.height() - adjust;
                                        if ($('html,body').scrollTop() < spanTop) {
                                            $('html,body').scrollTop(spanTop);
                                        }
                                }, 500);
							}*/
							bindTree($parent);
							bindAllEventsForTreeviewGrid($parent, true, data);
							// set proper padding to list items to make it like a tree layout
							$parent.find("tr.subdirectory").each(function () {
								var relLink = $("a[rel='" + $(this).attr("rel") + "']");
								var rootdir = escape(unescape($(this).attr("rootdir")));
								var dirSpan = $parent.find("span[rel='" + rootdir + "']");
								$(dirSpan).parent().removeClass('collapsed').addClass('expanded');
								$(dirSpan).find("img").attr("src", o.expandedImageURL);
								var padLeft = 0;
								if (relLink.parent().css("padding-left")) {
									try {
										padLeft = parseInt(relLink.parent().css("padding-left").replace("px", ""));
										// get current items padding information
									} catch (ex) {}
								} else {
									padLeft = 20;
									// Default padding is 20px
								}
								if (padLeft != NaN) {
									if (padLeft >= 20) {
										padLeft += 20; // add next level padding
										var padicon = padLeft;
										var padTree = padicon - 20;
										$(this).find("td.columnName").attr("style", "padding-left:" + padLeft + "px !important;");
									}
								}
                                prepareDataRow($(this));
							});
							if (expandedFolders) {
								// loop through expanded folders and set proper icon for expand view
								for (var item in expandedFolders) {
									if (expandedFolders[item].toLowerCase) {
										var rootdir = escape(unescape(expandedFolders[item]));
										var dirSpan = $parent.find("span[rel='" + rootdir + "']");
										$(dirSpan).parent().removeClass('collapsed').addClass('expanded');
										$(dirSpan).find("img").attr("src", o.expandedImageURL);
									}
								}
							}
                            if(window.enableFolderPreview)
                            {
                                window.quitPreviewCalls = true;
                                setTimeout(function(){
                                    window.quitPreviewCalls = false;
                                    fetchFolderPreview();
                                }, 500);
                            }
						} else if (locateFolder) {
							// Its simply showing all content of selected folder
							$(document).data("expandedFolders", []);
							scrollToFileListing();
							//If to  show folder items only
							//Get the html after XML parsing  for treeview
							var data = mapXmlToTable(responseData);
							//Replace all existing items  with new items and show them
							var $parent = parentElement.closest('table') || $parent;
							$parent.find(".headerSortDown").removeClass("headerSortDown");
							$parent.find(".headerSortUp").removeClass("headerSortUp");
							$parent.find("tbody").empty();
							$parent.append(data).find('TR:hidden').show();
							prepareDataRow(parentElement.find("tr"));
							bindTree($parent);
							bindAllEventsForTreeviewGrid(parentElement.closest('table'), true, data);
                            sortToDefaultsIfAvailable();
						} else {
							// Called for the first time
							$(document).data("expandedFolders", []);
							//If its called for first  time. Get the html after XML parsing for treeview
                            sortListing(false, false, true, true);
                            responseData = responseData || {};
                            responseData.listing = window.l;
							var data = mapXmlToTable(responseData);
							//Replace all existing items with new items and show them
							parentElement.find("tbody").append(data);
							bindTree(parentElement);
							parentElement.closest('table').find("tr").attr("style", "background-position:40px 3px !important;");
                            prepareDataRow(parentElement.find("tr"));
							bindAllEventsForTreeviewGrid(parentElement.closest('table'), true, data);
                            sortToDefaultsIfAvailable();
						}
					}
					// Bind properties of folder loaded
					bindCountOfFiles();
					try {
						window.cancelDrop();
					} catch (ex) {}
					// Select and show quota information for current folder
					if (responseData && responseData.quota) {
						window.quota = responseData.quota;
						if ($("div.itemCount").find("span.quotaText").length == 0 && window.quota && window.quota.length > 0) $("div.itemCount").append("<span class='quotaText'>&nbsp;&nbsp;" + window.quota + " " + getLocalizationKey('quotaAvailableLabelText') +"</span>");
					}
					// clear filter link event
					$("a.clearFilterLink", "#filterPanel").unbind("click").click(function(e) {
						e.preventDefault();
						if ($("#filter").val().length > 0) {
							$("#filter").val("").keyup().blur();
							window.last_search_item = false;
						}
						selectDeselectAllItems(false); //uncheck all items in grid/tree
						return false;
					});
				}

				//Method to show properties of loaded folder
				function bindCountOfFiles() {
					if (!window.listingInfo) window.listingInfo = {};
					var curDir = "/";
					if (hashListener.getHash() && hashListener.getHash().toString() != "") {
						curDir = unescape(hashListener.getHash().toString().replace("#", ""));
					}
					if (currentView() == "Thumbnail") {
						//sets listingInfo variable with various details of loaded folder
						window.listingInfo.totalItems = $("li", "#filesContainerDiv").length;
						window.listingInfo.totalVisibleItems = $("li:visible", "#filesContainerDiv").length;
						window.listingInfo.totalDirs = $("li.directoryThumb:visible", "#filesContainerDiv").length;
						window.listingInfo.totalFiles = window.listingInfo.totalVisibleItems - window.listingInfo.totalDirs;
						window.listingInfo.hiddenItems = $("li", "#filesContainerDiv").length - $("li:visible", "#filesContainerDiv").length;
						window.listingInfo.totalItemsInDir = window.listingInfo.totalItems + window.listingInfo.hiddenItems;
						window.listingInfo.filtered = false;
						if (curDir != window.listingInfo.curDir) {
							window.listingInfo.selectedEverything = false;
						}
						selectDeselectAllItems(window.listingInfo.selectedEverything);
						if (window.listingInfo.selectedEverything) {
							$("#selectionOfItemsOptions").show();
						}
						window.listingInfo.curDir = curDir;
						window.listingInfo.isSearchResult = $("#searchResultNotification").is(":visible");
						var msg = window.listingInfo.totalVisibleItems + " " + getLocalizationKey("FileCounterItemsText") + " (";
						if (window.listingInfo.totalDirs > 0) {
							msg += window.listingInfo.totalDirs + " " + getLocalizationKey("FileCounterFoldersText") + ", ";
						}
						msg += window.listingInfo.totalFiles + " " + getLocalizationKey("FileCounterFilesText") + ") "
						if (window.listingInfo.hiddenItems > 0) {
							msg += window.listingInfo.hiddenItems + " " + getLocalizationKey("FileCounterHiddenItemsText")
						}
						if (window.l && window.listingInfo.totalItems + window.listingInfo.hiddenItems < l.length) {
							var items = l.length;
							msg += getLocalizationKey("TotalItemsInDirMsgText").replace("{count}", items);
							window.listingInfo.totalItemsInDir = items;
						}
						$("div.itemCount").html(msg);
						if ($("div.itemCount").find("span.quotaText").length == 0 && window.quota && window.quota.length > 0) $("div.itemCount").append("<span class='quotaText'>&nbsp;&nbsp;" + window.quota + " " + getLocalizationKey('quotaAvailableLabelText') +"</span>");
						if (window.filteredItems && $("#filter").val().length > 0) {
							window.listingInfo.filtered = true;
							var files = window.filteredItems.filesCount;
							var dirs = window.filteredItems.dirsCount;
							window.listingInfo.totalDirs = dirs;
							window.listingInfo.totalFiles = files;
							window.listingInfo.totalItems = files + dirs;
							var FilterItemCountText = getLocalizationKey("FilterItemCountText");
							var itemCount = FilterItemCountText.replace("{filterVal}", $("#filter").val()).replace("{totalItems}", window.listingInfo.totalItems).replace("{folders}", dirs).replace("{files}", files);
							$("#itemCount").prepend("<span style='margin-right:15px;color:#777;'>" + itemCount + "</span>");
						}
					} else {
						window.listingInfo.totalItems = $("tr", "#filesContainer>tbody").length;
						window.listingInfo.totalVisibleItems = $("tr:visible", "#filesContainer>tbody").length;
						window.listingInfo.totalDirs = $("td.directory:visible", "#filesContainer>tbody").length;
						window.listingInfo.totalFiles = window.listingInfo.totalVisibleItems - window.listingInfo.totalDirs;
						window.listingInfo.hiddenItems = $("tr", "#filesContainer>tbody").length - $("tr:visible", "#filesContainer>tbody").length;
						window.listingInfo.totalItemsInDir = window.listingInfo.totalItems + window.listingInfo.hiddenItems;
						window.listingInfo.filtered = false;
						if (curDir != window.listingInfo.curDir) {
							window.listingInfo.selectedEverything = false;
						}
						selectDeselectAllItems(window.listingInfo.selectedEverything);
						if (window.listingInfo.selectedEverything) {
							$("#selectionOfItemsOptions").show();
						}
						window.listingInfo.curDir = curDir;
						window.listingInfo.isSearchResult = $("#searchResultNotification").is(":visible");
						var msg = window.listingInfo.totalVisibleItems + " " + getLocalizationKey("FileCounterItemsText") + " (";
						if (window.listingInfo.totalDirs > 0) {
							msg += window.listingInfo.totalDirs + " " + getLocalizationKey("FileCounterFoldersText") + ", ";
						}
						msg += window.listingInfo.totalFiles + " " + getLocalizationKey("FileCounterFilesText") + ") "
						if (window.listingInfo.hiddenItems > 0) {
							msg += window.listingInfo.hiddenItems + " " + getLocalizationKey("FileCounterHiddenItemsText")
						}
						if (window.l && window.listingInfo.totalItems + window.listingInfo.hiddenItems < l.length) {
							var items = l.length;
							msg += getLocalizationKey("TotalItemsInDirMsgText").replace("{count}", items);
							window.listingInfo.totalItemsInDir = items;
						}
						$("div.itemCount").html(msg);
						if ($("div.itemCount").find("span.quotaText").length == 0 && window.quota && window.quota.length > 0) $("div.itemCount").append("<span class='quotaText'>&nbsp;&nbsp;" + window.quota + " " + getLocalizationKey('quotaAvailableLabelText') +"</span>");
						if (window.filteredItems && $("#filter").val().length > 0) {
							window.listingInfo.filtered = true;
							var files = window.filteredItems.filesCount;
							var dirs = window.filteredItems.dirsCount;
							window.listingInfo.totalDirs = dirs;
							window.listingInfo.totalFiles = files;
							window.listingInfo.totalItems = files + dirs;
							var FilterItemCountText = getLocalizationKey("FilterItemCountText");
							var itemCount = FilterItemCountText.replace("{filterVal}", $("#filter").val()).replace("{totalItems}", window.listingInfo.totalItems).replace("{folders}", dirs).replace("{files}", files);
							$("#itemCount").prepend("<span style='margin-right:15px;color:#777;'>" + itemCount + "</span>");
						}
					}
				}

				// method to bind context menu on selectall checkbox to provide multiple options.
				function bindSelectionMenu() {
					if ($("a.selectionLink") && $("a.selectionLink").contextMenu) {
						$("a.selectionLink").contextMenu({
							menu: 'selectionMenu'
						}, function (action, el, pos, command) {
							handleCheckBoxContextMenuEvents(action, el, pos, command);
						}).click(function (evt) {
							evt.stopPropagation();
							evt.preventDefault();
							$(this).trigger("mousedown").trigger("mouseup");
							return false;
						});
					}
				}
				// method to bind paging size menu

				function bindPagingSizeMenu() {
					if ($("a.pageSizeSelectionLink") && $("a.pageSizeSelectionLink").contextMenu) {
						$("a.pageSizeSelectionLink").contextMenu({
							menu: 'pagingSizeMenu'
						}, function (action, el, pos, command) {
							handlePageSizeContextMenuEvents(action, el, pos, command);
						}).click(function (evt) {
							evt.stopPropagation();
							evt.preventDefault();
							$(this).trigger("mousedown").trigger("mouseup");
							return false;
						});
					}
				}

				// set of events combined to this method for thumbs view
				function bindAllEventsForThumbnailView(parentElement, data) {
					bindBreadcrumbs(); // breadcrumbs
					//Enable context menu
					var ok = true;
					try {
						if (noMenus) ok = false;
					} catch (e) {}
					if (ok) {
						$(".fileBox").contextMenu({
							menu: 'myMenu'
						}, function (action, el, pos, command) {
							handleContextMenuEvents(action, el, pos, command);
						});
					}
                    bindSortingToTreeviewGrid();
					bindGoToFolderEvents($(parentElement), o);
					//Remove spinner
					$('.wait').removeClass('wait');
					//blockFileListingUI(false);
					// Set item title text to fit width
					setTitleText();
					// Set icons to proper zoom as selection
					zoomInOutView(zoomSlider.slider("value"));
					checkFilesAvailable(data);
					refreshView();
					loadDirectoryPreview();
				}

				// set of events combined to this method for tree view
				function bindAllEventsForTreeviewGrid(element, checkForFiles, data) {
					$(element).find("tr:even").addClass("jqueryFileTreeAlt");
					howerEffect();
					bindCheckboxEvents();
					bindBreadcrumbs();
					//blockFileListingUI(false);
					if (checkForFiles) {
						checkFilesAvailable(data);
					}
					var itemCount = 0;
					if (currentView() == "Thumbnail") {
						itemCount = $("li", "#filesContainerDiv").length;
					} else {
						itemCount = $("tr", "#filesContainer>tbody").length;
						bindSortingToTreeviewGrid();
					}
					if (navigator.appName.indexOf("Explorer") < 0 || (navigator.appName.indexOf("Explorer") >= 0 && itemCount < 200)) {
						bindContextMenu(element); //no context menu on explorer...jsut too slow!
					}
					bindGoToFolderEvents(element, o);
					refreshView();
					loadDirectoryPreview();
				}

				//refreshes current view
				function refreshView() {
					// If to show items starting with a dot
					var hideItemsStartingWithDot = $.cookie(o.CookieHideItemStartingWithDot);
					hideItemsStartingWithDot = hideItemsStartingWithDot == "true";
					if (hideItemsStartingWithDot) {
						$("#SelectCheckboxContextMenuCheckItemsWithDotText").parent().hide();
					} else {
						$("#SelectCheckboxContextMenuCheckItemsWithDotText").parent().show();
					}
                    if(hideItemsStartingWithDot)
                        $("#hideItemsStartingWithDot").attr("checked", "checked");
                    else
                        $("#hideItemsStartingWithDot").removeAttr("checked");

					// If to show filter on screen
					var _hideFilter = $.cookie(o.CookieHideFilter);
					_hideFilter = _hideFilter == "true";
                    var selectionLink = $(".selectionLink").show();
					if (_hideFilter) {
						$(".filterArea").hide();
					} else {
						$(".filterArea").show();
					}
					// If to show checkbox column in listing
					var hideCheckBoxColumn = $.cookie(o.CookieHideCheckBoxColumn);
					if (hideCheckBoxColumn && hideCheckBoxColumn != "true") {
						hideCheckBoxColumn = $(document).data("disableCheckCol");
						if (hideCheckBoxColumn == "true") {
							$("#hideCheckBoxColumn").attr("disabled", "disabled");
						}
					}
					hideCheckBoxColumn = hideCheckBoxColumn == "true";
					// If to disable name column
					var disableNameCol = $(document).data("disableNameCol");
					disableNameCol = disableNameCol == "true";
					// If to disable size column
					var disableSizeCol = $(document).data("disableSizeCol");
					disableSizeCol = disableSizeCol == "true";
					// If to disable modified column
					var disableModifiedCol = $(document).data("disableModifiedCol");
					disableModifiedCol = disableModifiedCol == "true";
					// If to disable keywords column
					var disableKeywordsCol = $(document).data("disableKeywordsCol");
					disableKeywordsCol = disableKeywordsCol == "true";
                    window.hideKeywordCol = disableKeywordsCol;
                    window.hideModifiedCol = disableModifiedCol;
                    window.hideCheckboxCol = hideCheckBoxColumn;
                    window.hideNameCol = disableNameCol;
                    window.hideSizeCol = disableSizeCol;
					//Shows/hides columns and properties based on customization set
					if (currentView() == "Thumbnail") {
						if (hideItemsStartingWithDot) {
							$("div.imgTitle").find("a").each(

							function () {
								if ($.trim($(this).text()).charAt(0) == ".") {
									$(this).closest("li").hide().addClass("hiddenFile");
								}
							});
						} else {
							$("div.imgTitle").find("a").each(

							function () {
								if ($.trim($(this).text()).charAt(0) == ".") {
									$(this).closest("li").show().removeClass("hiddenFile");
								}
							});
						}
					} else {
                        var filesContainer = $("#filesContainer");
						if (hideCheckBoxColumn) {
							filesContainer.find("td.columnSelect").hide();
							filesContainer.find("thead > tr > td:first").hide();
                            selectionLink.hide();
						} else {
							filesContainer.find("td.columnSelect").show();
							filesContainer.find("thead > tr > td:first").show();
						}
						if (disableNameCol) {
							filesContainer.find("td.columnName,td.thName").hide();
						} else {
							filesContainer.find("td.columnName").show();
						}
						if (disableSizeCol) {
							filesContainer.find("td.columnSize,td.thSize").hide();
						} else {
							filesContainer.find("td.columnSize").show();
						}
						if (disableModifiedCol) {
							filesContainer.find("td.columnModified, td.thModified").hide();
						} else {
							filesContainer.find("td.columnModified, td.thModified").show();
						}
						if (disableKeywordsCol) {
							filesContainer.find("td.columnKeywords,td.thKeywords").hide();
						} else {
							filesContainer.find("td.columnKeywords").show();
						}
						if (hideItemsStartingWithDot) {
							$(".jqueryFileTree").find("a").each(

							function () {
								if ($.trim($(this).text()).charAt(0) == ".") {
									var el = $(this).closest("td");
									if ($(el).hasClass("directory")) {
										hideDirectoryFromTree($(el).closest("table").find('TR[rel="' + escape($(el).find("a").attr('rel')) + '"]'), true);
									}
									$(this).closest("tr").hide().addClass("hiddenFile");
								}
							});
						} else {
							$(".jqueryFileTree").find("a").each(

							function () {
								if ($.trim($(this).text()).charAt(0) == ".") {
									var el = $(this).closest("td");
									if ($(el).hasClass("directory")) {
										hideDirectoryFromTree($(el).closest("table").find('TR[rel="' + escape($(el).find("a").attr('rel')) + '"]'), false);
									}
									$(this).closest("tr").show().removeClass("hiddenFile");
								}
							});
						}
					}
					// re-bind file count
					bindCountOfFiles();
				}

				// Bind sorting to treeview grid
				function bindSortingToTreeviewGrid() {
					var filesContainer = jQuery('#filesContainer');
					var th = filesContainer.find('thead').find('td').addClass("header"),
						inverse = true;
					// sort direction
					window.listingSortDirection = $(document).data("listDefaultSortDirection") || "up";
					// column sorted
					window.listingSortColumn = $(document).data("listDefaultSortColumnIndex") || 1;
					// select default column to sort
					if ($("thead", filesContainer).find("td").eq(window.listingSortColumn)) {
						window.listingSortColumn = $("thead", filesContainer).find("td").eq(window.listingSortColumn).attr("colName");
						window.listingSortColumn = window.listingSortColumn || "name";
					} else {
						window.listingSortColumn = "name";
					}
					if (window.listingSortColumn) {
						if (window.listingSortDirection == "up") {
							inverse = false;
						}
					}
					if (!inverse) {
						$("thead", filesContainer).find("td[colName='" + window.listingSortColumn + "']").addClass("headerSortUp");
					} else {
						$("thead", filesContainer).find("td[colName='" + window.listingSortColumn + "']").addClass("headerSortDown");
					}
					$(".chkBoxAll", filesContainer).unbind().click(function (event) {
						var chkBox = $(this);
						toggleCheckBoxesAll($(this).closest("table"), chkBox.is(":checked"));
					});

					th.unbind().click(function () {
						if ($(this).hasClass("thSelect")) {
							return;
						}
						inverse = $(this).hasClass("headerSortUp");
						sortListing($(this).attr("colName"), inverse, true);
						$(this).parent().find(".headerSortDown").removeClass("headerSortDown");
						$(this).parent().find(".headerSortUp").removeClass("headerSortUp");
						if (!inverse) {
							$(this).removeClass("headerSortDown").addClass("headerSortUp");
						} else {
							$(this).removeClass("headerSortUp").addClass("headerSortDown");
						}
					});
				}

				// Bind sorting to treeview grid in basket
				function bindSortingToBasketTreeviewGrid() {
					var th = jQuery('#FileBasketList').find('thead > tr > td').addClass("header"),
						inverseBasket = true;
					// sort direction
					window.listingSortDirectionBasket = $(document).data("listDefaultSortDirection") || "up";
					// column sorted
					window.listingSortColumnBasket = $(document).data("listDefaultSortColumnIndex") || 1;
					var basketFilesContainer = $("table#basketFilesContainer");
					// select default column to sort
					if ($("thead", basketFilesContainer).find("td").eq(window.listingSortColumnBasket)) {
						window.listingSortColumnBasket = $("thead", basketFilesContainer).find("td").eq(window.listingSortColumnBasket).attr("colName");
						window.listingSortColumnBasket = window.listingSortColumnBasket || "name";
					} else {
						window.listingSortColumnBasket = "name";
					}
					if (window.listingSortColumnBasket) {
						if (window.listingSortDirectionBasket == "up") {
							inverseBasket = false;
						}
					}
					if (!inverseBasket) {
						$("thead", basketFilesContainer).find("td[colName='" + window.listingSortColumnBasket + "']").addClass("headerSortUp");
					} else {
						$("thead", basketFilesContainer).find("td[colName='" + window.listingSortColumnBasket + "']").addClass("headerSortDown");
					}
					$(".chkBoxAll", basketFilesContainer).unbind().click(function (event) {
						var chkBox = $(this);
						if(chkBox.is(":checked"))
							basketFilesContainer.find(".chkBox").attr("checked", "checked");
						else
							basketFilesContainer.find(".chkBox").removeAttr("checked");
					});
					// Add sorting event
					th.unbind().click(function () {
						if ($(this).hasClass("thSelect")) {
							return;
						}
						inverseBasket = !inverseBasket;
						sortBasketListing($(this).attr("colName"), inverseBasket, true);
						$(th).parent().find(".headerSortDown").removeClass("headerSortDown");
						$(th).parent().find(".headerSortUp").removeClass("headerSortUp");
						if (!inverseBasket) {
							$(this).removeClass("headerSortDown").addClass("headerSortUp");
						} else {
							$(this).removeClass("headerSortUp").addClass("headerSortDown");
						}
					});
					if (!$("#FileBasketList").data("sortingAdded")) {
						// Sort the list with options selected above.
						sortBasketListing(window.listingSortColumnBasket, inverseBasket, true);
						$("#FileBasketList").data("sortingAdded", true);
					}
				}

				// Context menu events
				function bindContextMenu(elems) {
					var addMenu = true;
					// noMenus is global variable, if it is set to true no context menu should be bound
					try {
						if (noMenus) addMenu = false;
					} catch (e) {}
					if (addMenu) {
						var $filesContainer = elems || $("#filesContainer");
						$("td.fileTR, td.directory, td.file").contextMenu({
							menu: 'myMenu',
							addHoverClass: true
						}, function (action, el, pos, command) {
							handleContextMenuEvents(action, el, pos, command);
						});
					}
					$(".chkBoxAll").contextMenu({
						menu: 'checkBoxMenu'
					}, function (action, el, pos, command) {
						handleCheckBoxContextMenuEvents(action, el, pos, command);
					});
				}

				// sets a message if nothing to display, else clears loading info
				function checkFilesAvailable(fileList) {
					if ((fileList && fileList.length == 0) || !fileList) {
                        var ovrlayBGColor = window.noFilesOverlayBGColor || "#000";
                        var overlayTransparency = window.noFilesOverlayTransparency || 0.6;
						o.FileListingElement.block({
							message: getLocalizationKey("FilesNotAvailableMessage"),
							css: {

								border: 'none',
								padding: '5px',
								backgroundColor: '#fff',
								color: '#000',
								width: '200px',
								'margin-left': '-100px',
								top: '40px',
								left: '50%',
								'-webkit-border-radius': '10px',
								'-moz-border-radius': '10px',
								'text-align': 'center',
								'font-size': '11px'
							},
                            overlayCSS :
                            {
                                backgroundColor : ovrlayBGColor,
                                opacity : overlayTransparency
                            }
						});
					} else {
						o.FileListingElement.unblock();
					}
				}

				// This method loops through list item and sets data like name, size, privs etc for each item. Which isused later on actions.
				function prepareDataRow(elems) {
					$(elems).each(function () {
                        if(typeof $(this).data("dataRow") == "undefined")
                        {
    						var keywords = unescape($(this).attr("keywords"));
    						if (keywords && keywords.length >= o.keywordsCharLimit) {
    							keywords = keywords.substr(
    							0, o.keywordsCharLimit) + "...";
    						}
    						var data = {
    							name: $(this).attr("name"),
    							size: $(this).attr("size"),
    							sizeB: $(this).attr("sizeInBytes"),
    							date: $(this).attr("date"),
    							fulldate: $(this).attr("fulldate"),
    							keywords: keywords,
    							preview: $(this).attr("preview"),
    							root_dir: $(this).attr("root_dir"),
    							privs: unescape($(this).attr("privs"))
    						};
    						$(this).data("dataRow", data);
    						$(this).removeAttr("name").removeAttr("size").removeAttr("date").removeAttr("privs").removeAttr("fulldate");
                        }
					});
				}
				var regexpCache = {};

				// Adds line break in title of an item if it exceeds provided length
				function wbr(str, num) {
					if (!regexpCache[num]) {
						regexpCache[num] = RegExp("(\[^\s-].{" + num + "})(?=\[^\s-].)", "g");
					}
					return str.replace(regexpCache[num], "$1<br>");
				}

				// Sets title of an item based on allowed characters length
				function setTitleText(elem, chars) {
					elem = elem || $(".imgTitle").find("a");
					chars = chars || o.thumbnailTextCharsLimit;
					elem.addClass("wordwrap");
					if ($.browser.msie && parseInt(jQuery.browser.version) == 8) {
						elem.each(function () {
							try {
								var title = $(this).closest("li").data("dataRow").name;
								$(this).html(wbr($(this).text(), chars));
							} catch (ex) {}
						});
					}
				}

                function bindDragDropFiles()
                {
                    var is_MacOs = navigator.userAgent.indexOf('Mac') > -1;
                    var is_chrome = navigator.userAgent.indexOf('Chrome') > -1;
                    var dragUIInformationPopup = $("#dragUIInformationPopup");
                    if($(document).data("crushftp_version") && ($(document).data("crushftp_version")+"").indexOf("6") >= 0)
                    {
                        var filesListing = $("#filesListing");
                        if(currentView() == "Thumbnail") {
                            var draggableItems = filesListing.find("[draggable]");
                            draggableItems = draggableItems.filter(":not(.dndApplied)");
                            draggableItems.addClass('dndApplied');
                            draggableItems.crushDraggables("destroy");
                            draggableItems.crushDraggables({
                                revert: true,
                                delay : 300,
                                crushdrag : function(event) {
                                    $(".dragdropItems").hide();
                                },
                                stop: function(event, ui) {
                                    filesListing.removeData("dragging");
                                    filesListing.removeData("draggingNames");
                                    $(".dragdropItems").hide();
                                    if(is_chrome)
                                        dragUIInformationPopup.slideUp('fast');
                                },
                                helper: function(e){
                                    window.disableVtip = true;
                                    if(is_chrome)
                                        dragUIInformationPopup.slideDown('fast');
                                    var elem = $(e.currentTarget);
                                    var selected = filesListing.find("li.fileBoxSelected:visible");
                                    var arrPath = [];
                                    arrPath.push(unescape(elem.attr("root_dir")));

                                    var arrFileNames = [];
                                    arrFileNames.push(elem.find("div.imgTitle").find("a").text());
                                    var arr = [];
                                    arr.push(unescape(elem.find("a:first").attr("rel")));
                                    selected.each(function(index, el) {
                                        var path = unescape($(this).find("a:first").attr("rel"));
                                        if(!arr.has(path))
                                            arr.push(path);

                                        var name = unescape($(this).find("div.imgTitle").find("a").text());
                                        if(!arrFileNames.has(name))
                                            arrFileNames.push(name);
                                    });
                                    var text = "Moving "+arr.length+" Items";
                                    if(arr.length==1)
                                        text = "Moving 1 Item";
                                    var list = $("<ul class='dragdropItems ui-corner-all ui-state-highlight'><li class='ui-priority-primary'>"+text+" <span class='targetPath'></span></li></ul>");
                                    if(arr.length>10)
                                    {
                                        for (var i = 0; i < 10; i++) {
                                            list.append("<li>"+arr[i]+"</li>");
                                        };
                                        var count = arr.length - 10;
                                        list.append("<li class='ui-priority-primary'>And "+ count + " more...</li>");
                                    }
                                    else
                                    {
                                        for (var i = 0; i < arr.length; i++) {
                                            list.append("<li>"+arr[i]+"</li>");
                                        };
                                    }
                                    filesListing.data("dragging", arr);
                                    filesListing.data("draggingNames", arrFileNames);
                                    return list;
                                },
                                appendTo:"body",
                                cursorAt : {left:-5, top : -5},
                                addClasses : false
                            });
                            filesListing.find("[draggable]").dragout()
                            var items = $(".fileThumb, .directoryThumb", filesListing.parent());
                            items.droppable("destroy");
                            items.droppable({
                              accept: ".fileThumb, .directoryThumb",
                              addClasses: false,
                              greedy: true,
                              tolerance: "pointer",
                              hoverClass : "uiDragHover",
                              drop : function(event, ui){
                                $(".dragdropItems").hide();
                                try{
                                    window.disableVtip = false;
                                    if($('.ui-draggable-dragging').length>0)
                                        $('.ui-draggable-dragging').draggable('option', 'revert', true).trigger('mouseup');
                                    $(".uiDragHover").removeClass('uiDragHover');
                                }catch(e){}
                                var items = filesListing.data("dragging");
                                var target;
                                var dropTo = $(event.target);
                                if(dropTo.is(".directoryThumb"))
                                {
                                    target = unescape(dropTo.find("a:first").attr("rel"));
                                }
                                else if(dropTo.is(".fileThumb"))
                                {
                                    target = unescape(dropTo.attr("root_dir"));
                                }
                                if(items && target)
                                {
                                    if(items.has(target))
                                    {
                                        growl("Error :", "Cant move "+target+" to same folder.", true, 3500);
                                        return false;
                                    }
                                    else
                                    {
                                        if(items[0]!="cut")
                                            items.unshift("cut");
                                        dragAndMove(target, items, filesListing.data("draggingNames"));
                                        filesListing.removeData("dragging");
                                        filesListing.removeData("draggingNames");
                                    }
                                }
                              }
                            });
                        }
                        else
                        {
                            var draggableItems = filesListing.find("[draggable]>td");
                            draggableItems = draggableItems.filter(":not(.dndApplied)");
                            draggableItems.addClass('dndApplied');
                            draggableItems.crushDraggables("destroy");
                            draggableItems.crushDraggables({
                                revert: true,
                                crushdrag : function(event) {
                                    $(".dragdropItems").hide();
                                },
                                stop: function(event, ui) {
                                    filesListing.removeData("dragging");
                                    $(".dragdropItems").hide();
                                    if(is_chrome)
                                        dragUIInformationPopup.slideUp('fast');
                                },
                                helper: function(e){
                                    if(is_chrome)
                                        dragUIInformationPopup.slideDown('fast');
                                    var elem = $(e.currentTarget).closest("tr");
                                    var selected = filesListing.find("input.chkBox:visible:checked").closest("tr");
                                    var arrFileNames = [];
                                    arrFileNames.push(elem.find("a:first").text());
                                    var arr = [];
                                    arr.push(unescape(elem.find("a:first").attr("rel")));
                                    selected.each(function(index, el) {
                                        var path = unescape($(this).find("a:first").attr("rel"));
                                        if(!arr.has(path))
                                            arr.push(path);

                                        var name = unescape($(this).find("a:first").text());
                                        if(!arrFileNames.has(name))
                                            arrFileNames.push(name);
                                    });
                                    var text = "Moving "+arr.length+" Items";
                                    if(arr.length==1)
                                        text = "Moving 1 Item";
                                    var list = $("<ul class='dragdropItems ui-corner-all ui-state-highlight'><li class='ui-priority-primary'>"+text+" <span class='targetPath'></span></li></ul>");
                                    if(arr.length>10)
                                    {
                                        for (var i = 0; i < 10; i++) {
                                            list.append("<li>"+arr[i]+"</li>");
                                        };
                                        var count = arr.length - 10;
                                        list.append("<li class='ui-priority-primary'>And "+ count + " more...</li>");
                                    }
                                    else
                                    {
                                        for (var i = 0; i < arr.length; i++) {
                                            list.append("<li>"+arr[i]+"</li>");
                                        };
                                    }
                                    filesListing.data("dragging", arr);
                                    filesListing.data("draggingNames", arrFileNames);
                                    return list;
                                },
                                appendTo:"body",
                                cursorAt : {left:-5, top : -5},
                                addClasses : false
                            });
                            filesListing.find("[draggable]").dragout()
                            var items = $(".dirItemTR, .fileItemTR, #filesListing", filesListing.parent());
                            items.droppable("destroy");
                            items.droppable({
                              accept: "td",
                              addClasses: false,
                              greedy: true,
                              tolerance: "pointer",
                              hoverClass : "uiDragHover",
                              drop : function(event, ui){
                                $(".dragdropItems").hide();
                                try{
                                    window.disableVtip = false;
                                    if($('.ui-draggable-dragging').length>0)
                                        $('.ui-draggable-dragging').draggable('option', 'revert', true).trigger('mouseup');
                                    $(".uiDragHover").removeClass('uiDragHover');
                                }catch(e){}
                                var items = filesListing.data("dragging");
                                var target;
                                if($(event.target).is("#filesListing"))
                                {
                                    target = unescape(hashListener.getHash().toString().replace("#", ""));
                                }
                                else
                                {
                                    var dropTo = event.target;
                                    if($(event.target).is(".dirItemTR"))
                                    {
                                        target = unescape($(dropTo).find("a:first").attr("rel"));
                                    }
                                    else if($(event.target).is(".fileItemTR"))
                                    {
                                        target = unescape($(dropTo).attr("rel"));
                                    }
                                }
                                if(items)
                                {
                                    if(items.has(target))
                                    {
                                        growl("Error :", "Cant move "+target+" to same folder.", true, 3500);
                                        return false;
                                    }
                                    else
                                    {
                                        if(items[0]!="cut")
                                            items.unshift("cut");
                                        dragAndMove(target, items, filesListing.data("draggingNames"));
                                        filesListing.removeData("dragging");
                                        filesListing.removeData("draggingNames");
                                    }
                                }
                              }
                            });
                        }
                    }
                }

				//Method to load icon previews, based on size and generic icon
				function loadIconPreview(size, force, elem, basket) {
					var genericIconTree = $(document).data("genericIconTree");
					var genericIconThumbnail = $(document).data("genericIconThumbnail");
					var randomNo = Math.random();
					var parentElem = basket ? $("#FileBasketList") : $("#filesListing");
					if (currentView(basket) == "Thumbnail") {
						var zoomValue = parseInt(window.zoomSlider.slider("value")); // Current zoom level
						if(basket)
                        {
							zoomValue = parseInt(window.zoomSliderBasket.slider("value")); // Current zoom level
                        }
						size = size || 2; // default size is 2
						var iconSize = 48;
						if (zoomValue < 3) {
							iconSize = 48; //Icon size 48 if zoom level is less than 3
						} else if (zoomValue < 6) {
							iconSize = 128; //Icon size 128 if zoom level is less than 6
						} else if (zoomValue < 10) {
							iconSize = 256; //Icon size 256 if zoom level is less than 10
						} else {
							iconSize = 512; //Icon size 512 if zoom level is higher than 10
						}
						var disableHover = false;
						if ($(document).data("disableThumbnailHover") && $(document).data("disableThumbnailHover") == "true") disableHover = true;
						if (!disableHover) {
							disableHover = zoomValue >= 13; // hover info, tooltip should be disabled if zoom level is more than 12
						}
						if (disableHover) {
							//If hover is disabled, it will loop through items and disable tooltip
							$("li.directoryThumb", parentElem).each(function () {
								var $curElem = $(this);
								var item = $curElem.closest("li").addClass("vtipDisabled");
								if (item.attr("title")) {
									$(item).attr("_title", $(item).attr("title"));
									$(item).removeAttr("title");
								}
							});
						} else {
							//If hover is enabled, it will loop through items and enable tooltip
							$("li.directoryThumb", parentElem).each(function () {
								var $curElem = $(this);
								var item = $curElem.closest("li").removeClass("vtipDisabled");
								if (item.attr("_title")) {
									$(item).attr("title", $(item).attr("_title"));
									$(item).removeAttr("_title");
								}
							});
						}
						// Not required for directory icon
						if (elem && elem.hasClass("directoryThumb")) {
							return;
						}
						var opt = false;
						if (force) {
							// load icons forcefuly
							if (elem) {
								opt = $(elem).data("dataRow");
								elem = elem.closest("li") || elem;
								if (elem.hasClass("vtip")) {
                                    var tooltipText = "<strong>"+localizations.TooltipNameLabelText+" : </strong>"+elem.find("div.imgTitle>a").text()+"<br /><strong>"+localizations.TooltipSizeLabelText+" : </strong>"+opt.size+ " <span class='syncSc'>("+opt.sizeB+" bytes)</span><br /><strong>"+localizations.TooltipModifiedLabelText+" : </strong>"+opt.date+"<br /><strong>"+localizations.TooltipKeywordsLabelText+" : </strong> "+crushFTPTools.xmlEncode(opt.keywords);
									elem.attr("title", tooltipText);
								}
								elem = elem.find("a.imgLink").find("img");
								elem.removeClass("loadedPreview").attr("src", o.spinerImage);
							} else {
								$("img.loadedPreview", parentElem).removeClass("loadedPreview").attr("src", o.spinerImage);
							}
						}
						elem = elem || $("img[src$='" + o.spinerImage + "']", parentElem);
						// Loop through items and load preview icons, if icon not available generic icon will be shown
						elem.each(function () {
							var $curElem = $(this);
                            if($curElem.closest("li").hasClass("directoryThumb")) {
                                return;
                            }
							if (disableHover) {
								var item = $curElem.closest("li").addClass("vtipDisabled");
								if (item.attr("title")) {
									$(item).attr("_title", $(item).attr("title"));
									$(item).removeAttr("title");
								}
							} else {
								var item = $curElem.closest("li").removeClass("vtipDisabled");
								if (item.attr("_title")) {
									$(item).attr("title", $(item).attr("_title"));
									$(item).removeAttr("_title");
								}
							}
							// binds images' load event
							$curElem.unbind().bind("load", function (e) {
								var parentElem = $(this).closest("li") || parentElem;
								var relLink = parentElem.find("a:first");
								var $this = $(this);
								$(this).removeAttr("width").removeAttr("height").css({
									width: "",
									height: ""
								});
								var pic_real_width = this.width;
								var pic_real_height = this.height;
                                var imgRatio = pic_real_width / pic_real_height;
                                var divRatio = $this.closest("div").width() / $this.closest("div").height();
								// Calculate image's real width and height and fix it to fit to the image holder DIV
								if (pic_real_width < $this.closest("div").width() && pic_real_height < $this.closest("div").height()) {
									$this.css("height", "auto");
									$this.css("width", "auto");
								}
                                else if (imgRatio > divRatio) {
									$this.css("height", "auto");
									$this.css("width", $this.closest("div").width());
								} else {
									$this.css("width", "auto");
									$this.css("height", $this.closest("div").height());
								}
							}).error(function(){
                                if ($.browser.msie)
                                {
                                    if($(this).attr("ie_hasPreview"))
                                        return;
                                }
								var fileName = $(this).closest("li").find(".imgTitle").text();
								var ext = getFileExtension(fileName);
								if (o.availableFileExtensionImages.has(ext)) {
									$(this).attr("src", o.FileExtensionImageFilePath + ext + "_"+iconSize+".png");
								} else {
									$(this).attr("src", o.fileLarge + "_"+iconSize+".png").attr("style", o.PreviewIconThumbnailStyle);
								}
							});
							var genericIcon = true;
							var itemListed = $curElem.closest("li");
							opt = itemListed.data("dataRow");
                            if (opt && opt.preview && opt.preview.toString() != "0") {
								//if current item has preview, show preview image as an icon. Generic icon otherwise
								if (!genericIconThumbnail && !itemListed.is(".directoryThumb")) {
									$curElem.attr("src", o.ajaxCallURL + "?command=getPreview&size=" + size + "&path=" + crushFTPTools.encodeURILocal(unescape($curElem.parent().attr("rel"))) + "&frame=1").attr("style", o.PreviewIconThumbnailStyle);
                                    if ($.browser.msie)
                                    {
                                        $curElem.attr("ie_hasPreview", "true");
                                    }
									genericIcon = false;
								}
								var parentElem = itemListed || $curElem;
								var relLink = parentElem.find("a:first");
								var title = $(parentElem).attr("title") || $(parentElem).attr("original-title");
								if (title && title.indexOf("getPreview") < 0) {
									$(parentElem).attr("title", "<img src=\"" + o.ajaxCallURL + "?command=getPreview&size=3&path=" + crushFTPTools.encodeURILocal(unescape(relLink.attr("rel"))) +"&frame=1" + "\" border=\"0\" /> <br />" + $(parentElem).attr("title"));
								}
							}
							// If generic icon to be shown, set it based on current file's extension. Which will be replaced with common file icon if current icon set does not have an icon for this extension.
							if (genericIcon) {
								var fileName = $(this).closest("li").find(".imgTitle").text();
								var ext = getFileExtension(fileName);
								if (o.availableFileExtensionImages.has(ext)) {
									$(this).attr("src", o.FileExtensionImageFilePath + ext + "_" + iconSize + ".png");
								} else {
									$(this).attr("src", o.fileLarge + "_" + iconSize + ".png").attr("style", o.PreviewIconThumbnailStyle);
								}
							}
							var src = $(this).attr("src");
							$(this).attr("src", "");
							$(this).attr("src", src).addClass("loadedPreview");
						});
						//Resetting iconSize as this will be used when preview images load
						if (zoomValue < 3) {
							$("li.directoryThumb", parentElem).find("a.imgLink").find("img").attr("src", o.fileFolder);
							iconSize = 48;
						} else if (zoomValue < 6) {
							$("li.directoryThumb", parentElem).find("a.imgLink").find("img").attr("src", o.fileFolder1);
							iconSize = 128;
						} else if (zoomValue < 10) {
							$("li.directoryThumb", parentElem).find("a.imgLink").find("img").attr("src", o.fileFolder2);
							iconSize = 256;
						} else {
							$("li.directoryThumb", parentElem).find("a.imgLink").find("img").attr("src", o.fileFolder3);
							iconSize = 512;
						}
					} else {
						//for treeview
						size = size || 1; // default size for preview icon is 1 for treeview
						elem = elem || $("td.fileTR", parentElem);
						var disableHover = false;
						if ($(document).data("disableTreeviewHover") && $(document).data("disableTreeviewHover") == "true") disableHover = true;
						// loop through images and load relevant preview or generic icon
						elem.each(function () {
							var $curElem = $(this);
							var newImg = $("<img />");
							if ($curElem && $curElem.hasClass("directory")) {
								return;
							}
							$curElem.find(".previewIcon").remove();
							$curElem.prepend("<span class=\"previewIcon\"></span>");
							$curElem.find(".previewIcon").append(newImg);
							// If item has preview and no generic icon to show
							if ($curElem.attr("preview") != "0" && !genericIconTree) {
								newImg = $curElem.find("img");
								newImg.attr("src", o.ajaxCallURL + "?command=getPreview&size=" + size + "&path=" + crushFTPTools.encodeURILocal(unescape($curElem.find("a").attr("rel"))) + "&frame=1");
								var relLink = $curElem.find("a").addClass("iconPreviewLink");
								$curElem.removeClass("fileItem");
								if (!disableHover) {
									$curElem = $curElem.find("a").addClass("vtip");
									$curElem.attr("title", "<img src=\"" + o.ajaxCallURL + "?command=getPreview&size=3&path=" + crushFTPTools.encodeURILocal(unescape(relLink.attr("rel"))) + "&frame=1" + "\" border=\"0\" />");
									vtip($curElem);
								}
							} else {
								//If generic icon to show
								newImg = $curElem.find("img");
								var fileName = $curElem.find("a:first").text();
								var ext = getFileExtension(fileName);
								if (o.availableFileExtensionImages.has(ext)) {
									newImg.attr("src", o.FileExtensionImageFilePath + ext + "_16.png");
								} else {
									newImg.attr("src", o.fileLarge + "_16.png").attr("style", o.PreviewIconThumbnailStyle);
								}
								if ($curElem.attr("preview") != "0") {
									var relLink = $curElem.find("a").addClass("iconPreviewLink");
									$curElem.removeClass("fileItem");
									if (!disableHover) {
										$curElem = $curElem.find("a").addClass("vtip");
										$curElem.attr("title", "<img src=\"" + o.ajaxCallURL + "?command=getPreview&size=3&path=" + crushFTPTools.encodeURILocal(unescape(relLink.attr("rel"))) +"&frame=1" + "\" border=\"0\" />");
										vtip($curElem);
									}
								}
							}
						});
					}
				}

				// Bind view changer links events.
				function bindEventsToViewChanger() {
					$(".thumbnailViewLink,.treeViewLink").unbind("click").click(
					function (evt) {
						var isBasket = $(this).parent().attr("id") == "viewSelectorPanelBasket";
						if ($(this).attr("rel") != currentView(isBasket)) {
							$(this).parent().find("a").animate({
								opacity: 1
							}, 0);
							$(this).animate({
								opacity: 0.3
							}, 500);
							changeView($(this).attr("rel"), true, isBasket);
						}
						$(this).blur();
						evt.preventDefault();
						return false;
					});
					if (!$("#slider").attr("added")) {
						window.zoomSlider = $("#slider").slider({
							min: 0,
							max: 30,
							change: function (event, ui) {
								zoomInOutView(ui.value);
							}
						});
                        if(typeof window.defaultThumbnailSize != "undefined")
                        {
                            window.zoomSlider.slider("value", window.defaultThumbnailSize);
                        }
					}
					if (!$("#sliderBasket").attr("added")) {
						window.zoomSliderBasket = $("#sliderBasket").slider({
							min: 0,
							max: 30,
							change: function (event, ui) {
								zoomInOutView(ui.value, false, true);
							}
						});
					}
				}
				bindEventsToViewChanger();
				//Method which sets elements sizes based on zoom level
				window.zoomInOutView = function (val, elem, basket) {
					elem = elem || false;
					if (val > 0) {
						if(basket)
						{
							$.cssRule({
								".fileBoxBasket": [
									["width", o.lowestThumbnailBoxWidth + (val * 30) + "px"],
									["height", o.lowestThumbnailBoxHeight + (val * 20) + "px"]
									]
							});
							$.cssRule({
								".fileBoxBasket .imgBox": [
									["height", o.lowestThumbnailBoxHeight + (val * 20) - 50 + "px"]
									]
							});
							$.cssRule({
								".fileBoxBasket .imgWrapper": [
									["height", o.lowestThumbnailBoxHeight + (val * 20) - 52 + "px"]
									]
							});
						}
						else
						{
							$.cssRule({
								".fileBox": [
									["width", o.lowestThumbnailBoxWidth + (val * 30) + "px"],
									["height", o.lowestThumbnailBoxHeight + (val * 20) + "px"]
									]
							});
							$.cssRule({
								".fileBox .imgBox": [
									["height", o.lowestThumbnailBoxHeight + (val * 20) - 50 + "px"]
									]
							});
							$.cssRule({
								".fileBox .imgWrapper": [
									["height", o.lowestThumbnailBoxHeight + (val * 20) - 52 + "px"]
									]
							});
						}
						if (val >= 5) {
							loadIconPreview(3, true, elem, basket);
						} else {
							loadIconPreview(2, true, elem, basket);
						}
					} else {
						if(basket)
						{
							$.cssRule({
								".fileBoxBasket": [
									["width", o.lowestThumbnailBoxWidth + "px"],
									["height", o.lowestThumbnailBoxHeight + "px"]
									]
							});
							$.cssRule({
								".fileBoxBasket .imgBox": [
									["height", o.lowestThumbnailBoxHeight - 50 + "px"]
									]
							});
							$.cssRule({
								".fileBoxBasket .imgWrapper": [
									["height", o.lowestThumbnailBoxHeight - 52 + "px"]
									]
							});

						}
						else
						{
							$.cssRule({
								".fileBox": [
									["width", o.lowestThumbnailBoxWidth + "px"],
									["height", o.lowestThumbnailBoxHeight + "px"]
									]
							});
							$.cssRule({
								".fileBox .imgBox": [
									["height", o.lowestThumbnailBoxHeight - 50 + "px"]
									]
							});
							$.cssRule({
								".fileBox .imgWrapper": [
									["height", o.lowestThumbnailBoxHeight - 52 + "px"]
									]
							});
						}
						loadIconPreview(2, true, elem, basket);
					}
					if ($.browser.msie && parseInt(jQuery.browser.version) == 8) {
						var charlimit = o.thumbnailTextCharsLimit + (val * 4);
						setTitleText(false, charlimit);
					}
				}
				// Events to bind on items to navigate folders

				function bindGoToFolderEvents(t, o) {
                    var filesListing = $("#filesListing");
					if (currentView() == "Thumbnail") {
						$(t).find('a', 'LI.fileBox').unbind("click").click(function (evt) {
							var curitem = $(this).closest("li.fileBox");
							curitem.attr("shift", evt.shiftKey); // If shift is pressed it will allow multiple item selection in thumbs view
							curitem.trigger("click");
							$(this).blur();
							return false;
						});
						$(t).find('LI.fileBox').unbind("click").click(function (evt) {
                            evt.stopPropagation();
                            evt.preventDefault();
                            $(this).trigger('mouseup');
							window.listingInfo.selectedEverything = false;
							$("#selectionOfItemsOptions").hide();
							var curitem = $(this);
							var shift = evt.shiftKey || curitem.attr("shift") == "true"; // If shift is pressed it will allow multiple item selection in thumbs view
							curitem.removeAttr("shift");
							if (shift) {
								if (window.lastSelectedItem) // Last selected item, if shift is pressed
								{
									var lastItem = window.lastSelectedItem;
									window.lastSelectedItem = false;
									if (lastItem != curitem) //If current and last items are not same
									{
										var lastItemIndex = parseInt($(lastItem).attr("index"));
										var curItemIndex = parseInt($(curitem).attr("index"));
										var isChecked = $($(t).find("li").get(lastItemIndex)).hasClass("fileBoxSelected");

										//loop through items between last selected and current, and apply selection class
										if (lastItemIndex > curItemIndex) {
											for (var i = curItemIndex; i <= lastItemIndex; i++) {
												if ($($(t).find("li").get(i)).is(":visible")) {
													if(isChecked)
														$($(t).find("li").get(i)).addClass("fileBoxSelected");
													else
														$($(t).find("li").get(i)).removeClass("fileBoxSelected");
												}
											}
										}
										//reverse loop if below item selected first
										if (curItemIndex > lastItemIndex) {
											for (var i = lastItemIndex; i <= curItemIndex; i++) {
												if ($($(t).find("li").get(i)).is(":visible")) {
													if(isChecked)
														$($(t).find("li").get(i)).addClass("fileBoxSelected");
													else
														$($(t).find("li").get(i)).removeClass("fileBoxSelected");
												}
											}
										}
									}
								}
							} else {
								//If only single item selection (without shift)
								if (curitem.hasClass("fileBoxSelected")) // If already selected, unselect. Select otherwise
								{
									curitem.removeClass("fileBoxSelected");
								} else {
									curitem.addClass("fileBoxSelected");
								}
								window.lastSelectedItem = curitem;
							}
							// Remove selection range, it messes up UI as all the text came between selection highlights in native browser selection manner
							if (window.getSelection) // Modern Browsers
							{
								var selection = window.getSelection();
								if (selection.removeAllRanges) {
									selection.removeAllRanges();
								}
							}
							if (document.getSelection) // IE
							{
								var selection = document.getSelection();
								if (selection.removeAllRanges) {
									selection.removeAllRanges();
								}
							}
							//Show selection info bar if items are hidden in paging.
							if ($(t).find("li.fileBoxSelected").length == window.listingInfo.totalVisibleItems) {
								showSelectionInfoBar();
							}
							$(this).blur();
							return false;
						});
						//Event of double click on thumb icon loads that folder, if file selected, downloads that file.

						var hasTouch = false; // Check if application is loaded on touch supported device
						var agent = navigator.userAgent.toLowerCase();
						if (agent.indexOf('iphone') >= 0 || agent.indexOf('ipad') >= 0 || agent.indexOf('android') >= 0)
						{
							hasTouch = true;
						}
						function thumbFolderEvent(elem) {
							$(".cluetip-default").remove();
							if ($(elem).hasClass("directoryThumb")) { // If directory
								window.current_page = o.pagingCurrentPage = 0;
								$(document).removeData("searchData");
                                window.last_search_item = "";
                                $("#filter").val("").keyup().blur();
								var loc = $(elem).find("a.imgLink").attr('rel').match(/.*\//);
								if (loc) {
									blockFileListingUI(true);
									setHashLocation(loc); // Just sets a location, loading of that folder will be done by hash listener.
									$(".cluetip-default").remove();
								}
							} else { // If file
								var fileName = $(elem).find("a:first").attr("rel");
								var fileExt = getFileExtension(fileName);
								if(fileExt) fileExt = fileExt.toLowerCase();

								var extsToOpenPreview = $(document).data("OPEN_PREVIEW_EXTENSIONS"); // Extensions which should open preview window than download, ie. images and videos
								if (extsToOpenPreview && extsToOpenPreview.length > 0 && fileExt.length > 0 && extsToOpenPreview.has(fileExt)) {
									$(document).data("currentContext", {
										'elem' : $(elem)
									});
									mediaPreview(true, true);
								}
								else
								{
									var extsToOpen = $(document).data("OPEN_NEW_WINDOW_EXTENSIONS"); // Extensions which should open in a window than download, ie. images
                                    var iOS = navigator.userAgent.match(/(iPad|iPhone|iPod)/g) ? true : false;
									if ((extsToOpen && extsToOpen.length > 0 && fileExt.length > 0 && extsToOpen.has(fileExt)) || iOS) { // If file to be shown in window
										window.open(fileName);
									} else {
										//Downloads item/file
										downloadItems(false, $(elem));
									}
								}
							}
							$(elem).blur();
							return false;
						}
						if(!hasTouch)
						{
							$(t).find('LI.fileBox').unbind(o.thumbFolderEvent);
							$(t).find('LI.fileBox').bind(o.thumbFolderEvent, function(){
								thumbFolderEvent($(this));
							});
						}
						else
						{
							$(t).find('LI.fileBox').doubletap(function(event, elem){
								thumbFolderEvent(elem);
							});
						}
					} else { //Treeview
						$(t).find('TD A').unbind(o.folderEvent);
						$(t).find('TD A').bind(o.folderEvent, function (evt) { // Binds click to each file name, click on folder shows content of folder, downloads if file
							$("#cluetip").hide();
							if (evt.ctrlKey || filesListing.data("dragging")) // Ctrl + click opens context menu. A hack for laptop users. Stop event if ctrl+click.
							{
								evt.stopPropagation();
								evt.preventDefault();
                                if(filesListing.data("dragging"))
                                {
                                    setTimeout(function(){
                                        try{
                                            window.disableVtip = false;
                                            if($('.ui-draggable-dragging').length>0)
                                                $('.ui-draggable-dragging').draggable('option', 'revert', true).trigger('mouseup');
                                            $(".uiDragHover").removeClass('uiDragHover');
                                        }catch(e){}
                                        filesListing.removeData("dragging");
                                        filesListing.removeData("draggingNames");
                                        $(".dragdropItems").hide();
                                    }, 500);
                                }
								return false;
							}

							if ($(this).parent().hasClass("directory")) { // If directory
								window.current_page = o.pagingCurrentPage = 0;
								$(document).removeData("searchData");
                                window.last_search_item = "";
                                $("#filter").val("").keyup().blur();
								var loc = $(this).prev().attr('rel').match(/.*\//);
								if (loc) {
									setHashLocation(loc); // Just set hash in location bar, everything else done by hash listener
								}
							} else { // If file
								var fileName = $(this).closest("td").find("a:first").attr("rel");
								var fileExt = getFileExtension(fileName);
								if(fileExt) fileExt = fileExt.toLowerCase();
								var extsToOpenPreview = $(document).data("OPEN_PREVIEW_EXTENSIONS"); // Extensions which should open preview window than download, ie. images and videos
								if (extsToOpenPreview && extsToOpenPreview.length > 0 && fileExt.length > 0 && extsToOpenPreview.has(fileExt)) {
									$(document).data("currentContext", {
										'elem' : $(this).closest("td")
									});
									mediaPreview(true, true);
								}
								else
								{
									var extsToOpen = $(document).data("OPEN_NEW_WINDOW_EXTENSIONS"); // Extensions which should open in a window than download, ie. images
                                    var iOS = navigator.userAgent.match(/(iPad|iPhone|iPod)/g) ? true : false;
									if ((extsToOpen && extsToOpen.length > 0 && fileExt.length > 0 && extsToOpen.has(fileExt)) || iOS) { // If file to be shown in window
										window.open(fileName);
									} else {
										//Downloads item/file
										downloadItems(false, $(this).closest("td"));
									}
								}
							}
							$(this).blur();
							return false;
						});
					}
				}

				// Checkbox events for treeview
				function bindCheckboxEvents() {
					var lastChecked = false;
					var $chkboxes = $("tr.jqueryFileTree", $("#filesListing")).not(".file").find(".chkBox").unbind("click").click(function(event) {
						checkUnCheckDirectory($(this).parent(), $(this).is(":checked")); //Check or uncheck parent directory checkbox if all items beneath are selected/not selected
						toggleMainCheckbox($(this).closest("table")); //Check or uncheck check all checkbox if all items are selected/not selected
						window.listingInfo.selectedEverything = false;
						$("#selectionOfItemsOptions").hide();
						// Show selection info bar if there are items hidden in paging
						if ($("#filesContainer").find(".chkBox:visible:checked").length == window.listingInfo.totalVisibleItems) {
							showSelectionInfoBar();
						}
						if(!lastChecked) {
							lastChecked = this;
							return;
						}
						else if(event.shiftKey) {
							var start = $chkboxes.index(this);
							var end = $chkboxes.index(lastChecked);
							$chkboxes.slice(Math.min(start,end), Math.max(start,end)+ 1).attr('checked', lastChecked.checked);
							checkUnCheckDirectory($(this).parent(), $(this).is(":checked")); //Check or uncheck parent directory checkbox if all items beneath are selected/not selected
							toggleMainCheckbox($(this).closest("table")); //Check or uncheck check all checkbox if all items are selected/not selected
							window.listingInfo.selectedEverything = false;
							$("#selectionOfItemsOptions").hide();
							// Show selection info bar if there are items hidden in paging
							if ($("#filesContainer").find(".chkBox:visible:checked").length == window.listingInfo.totalVisibleItems) {
								showSelectionInfoBar();
							}
						}
						lastChecked = this;
					});
				}

				// Checkbox events for treeview in Basket
				function bindBasketCheckboxEvents() {
					var lastChecked = false;
					var $chkboxes = $("tr.jqueryFileTree", $("#filesBasket")).not(".file").find(".chkBox").unbind("click").click(function(event) {
						toggleMainCheckbox($(this).closest("table")); //Check or uncheck check all checkbox if all items are selected/not selected
						if(!lastChecked) {
							lastChecked = this;
							return;
						}
						else if(event.shiftKey) {
							var start = $chkboxes.index(this);
							var end = $chkboxes.index(lastChecked);
							$chkboxes.slice(Math.min(start,end), Math.max(start,end)+ 1).attr('checked', lastChecked.checked);
							toggleMainCheckbox($(this).closest("table")); //Check or uncheck check all checkbox if all items are selected/not selected
						}
						lastChecked = this;
					});
				}

				// Bind tree of items list
				function bindTree(t) {
                    showButtonsBasedOnPriviledge();
					if (currentView() != "Thumbnail") {
						// For tree view only
						$(t).find('span.expandButton').unbind(o.folderEvent);
						var ok = true;
						try {
							if (noMenus) ok = false;
						} catch (e) {}
						if (!ok) {
							$(t).find('span.expandButton').hide();
						}
						if (ok) {
							// Expand icon click
							$(t).find('span.expandButton').unbind(o.folderEvent).bind(o.folderEvent, function (event, callback) {
								if ($(this).parent().hasClass('collapsed')) {
									// Expand
									$(this).parent().removeClass('collapsed').addClass('expanded');
									var toLocate = $(this).parent().find("span.expandButton").find("img").attr("src", o.expandedImageURL);
									var spanTop = $(document).scrollTop();
                                    $('body').addClass('stop-scrolling');
									showTree($(this).parent(), escape($(this).attr('rel').match(/.*\//)), false, false, function(){
										if(callback)callback();
                                        $('body').removeClass('stop-scrolling');
										if ($('html,body').scrollTop() < spanTop) {
											$('html,body').animate({
												scrollTop: spanTop
											}, 0, false);
										}
									});
								} else {
									// Collapse
                                    var curScrollTop = $(document).scrollTop();
                                    removeDirectoryFromTree($(this).closest("table").find('TR[rel="' + $(this).attr('rel') + '"]'));
                                    var expandedFolder = $(this).attr('rel');
                                    var expandedFolders = $(document).data("expandedFolders");
                                    if (!expandedFolders) {
                                        expandedFolders = [];
                                    }
                                    if (expandedFolders.has(expandedFolder)) {
                                        expandedFolders.remove(expandedFolders.indexOf(expandedFolder));
                                    }
                                    $(document).data("expandedFolders", expandedFolders);
									reBuildListing(window.curTreeItems); // Rebuild items on screen
                                    $('html,body').animate({
                                        scrollTop: curScrollTop
                                    }, 0, false);
                                    /*// Scroll window to proper location for better user interface. As they dont have to scroll up. Non-IE only
									if ($("span[rel='" + expandedFolder + "']:first").length > 0) {
										var spanTop = $("span[rel='" + expandedFolder + "']:first").offset().top;
										if ($('html,body').scrollTop() < spanTop) {
											$('html,body').animate({
												scrollTop: spanTop-100
											}, 0, false);
										}
									}*/
								}
								$(this).blur();
								return false;
							});
						}
						bindGoToFolderEvents(t, o);
					}
					// Prevent A from triggering the # on non-click events
					if (o.folderEvent.toLowerCase != 'click') $(t).find('TD A').bind('click', function () {
						return false;
					});
					$(".cluetip-default").remove(); /* Load icon previews for images if available */
                    if($("#hideCheckBoxColumn").is(":checked"))
                    {
                        if(window.hideCheckBoxColumn)
                            window.hideCheckBoxColumn(true);
                    }
                    bindDragDropFiles();
					loadIconPreview(); /* Enable tooltips */
					vtip();
				}
				// Remove directory and it's sub-elements, used when deleted

				function removeDirectoryFromTree(trElems) {
					var rel = $(trElems.get(0)).attr("rel");
					var newItems = [];
					for (var i = 0; i < window.curTreeItems.length; i++) {
						var curItem = window.curTreeItems[i];
						if (escape(curItem.root_dir).indexOf(escape(unescape(rel))) != 0) {
							newItems.push(curItem);
						}
					}
					window.curTreeItems = newItems;
				}

				//Hide directory and subitems from the list
				function hideDirectoryFromTree(trElems, flag) {
					$(trElems).each(function () {
						$(this).find("td.directory").each(function () {
							hideDirectoryFromTree($(this).closest("table").find('TR[rel="' + escape($(this).find('a').attr('rel')) + '"]'));
						});
						if (flag) {
							$(this).hide();
						} else {
							$(this).show();
						}
					});
				}

				//Move elements on tree when sorting applied, recursive method
				function moveElementOnTreeAfterSorting(trElems) {
					$(trElems).each(function () {
						var parentTR = $(this);
						$(this).closest("table").find("tr[rel='" + $(this).find("a").attr("rel") + "']").each(function () {
							if ($(this).find("td.directory").length > 0) {
								$(parentTR).closest("tr").after($(this));
								moveElementOnTreeAfterSorting($(this).find("td.directory"));
							} else {
								$(parentTR).closest("tr").after($(this));
							}
						});
					});
				}

				//Returns current paging size (Items to show on a page)
				function getPageSize() {
					var CookiePageSize = $.cookie(o.CookiePageSize);
					if (!CookiePageSize) {
						var options = {
							path: '/',
							expires: 365
						};
						$.cookie(o.CookiePageSize, o.defaultPageSize, options);
						CookiePageSize = o.defaultPageSize;
					}
					if (CookiePageSize == 0) {
						return "all";
					} else {
						return CookiePageSize
					}
				}

				//Rebuid listing, rebind events and all other elements. Expects custom data to generate listing. Used in filter and other method when current items are modified ie. delete
				function reBuildListing(customData) {
					var data = generateListing(customData);
					if (currentView() == "Thumbnail") {
						var c = $("#filesContainerDiv");
						$(c).html(data);
						if(!$(c).next().is(".ignoreDB"))
							$(c).after("<div class='clear ignoreDB'></div>");
						//Bind various events
						prepareDataRow($(c).find("li"));
						bindTree();
						bindAllEventsForThumbnailView($(c), data);
						$("#slider").show();
						scrollToFileListing();
                        if(window.enableFolderPreview)
                        {
                            window.quitPreviewCalls = true;
                            setTimeout(function(){
                                window.quitPreviewCalls = false;
                                fetchFolderPreview();
                            }, 500);
                        }
					} else {
						var c = $("#filesContainer");
						$(c).find("tbody").empty().append(data);
						//blockFileListingUI(false);
						prepareDataRow($(c).find("tr"));
						bindTree(c);
						$(c).closest('table').find("tr").attr("style", "background-position:40px 3px !important;");
						bindAllEventsForTreeviewGrid($(c).closest('table'), true, data);
						c.find("tr.subdirectory").each(function () {
							var relLink = $("a[rel='" + $(this).attr("rel") + "']");
							var rootdir = escape($(this).attr("rootdir"));
							var dirSpan = c.find("span[rel='" + rootdir + "']");
							$(dirSpan).parent().removeClass('collapsed').addClass('expanded');
							$(dirSpan).find("img").attr("src", o.expandedImageURL);
							var padLeft = 0;
							if (relLink.parent().css("padding-left")) {
								try {
									padLeft = parseInt(relLink.parent().css("padding-left").replace("px", ""));
								} catch (ex) {}
							} else {
								padLeft = 20;
							}
							if (padLeft != NaN) {
								if (padLeft >= 20) {
									padLeft += 20;
									var padicon = padLeft;
									var padTree = padicon - 20;
									$(this).find("td.columnName").attr("style", "padding-left:" + padLeft + "px !important; background-position:" + padTree + "px 4px !important;");
								}
							}
						});
                        if(window.enableFolderPreview)
                        {
                            window.quitPreviewCalls = true;
                            setTimeout(function(){
                                window.quitPreviewCalls = false;
                                fetchFolderPreview();
                            }, 500);
                        }
					}
					if(!$.CrushFTP.DNDAdded)
					{
						$.CrushFTP.attachDND(o);
						$.CrushFTP.DNDAdded = true;
					}
				}
				// Update page size and refresh layout

				function updatePageSizeOnLayout(refresh, customItem) {
					var CookiePageSize = getPageSize();
					o.defaultPageSize = CookiePageSize;
					var pageText = getLocalizationKey("PageSizeSelectionLinkText").replace("{0}", CookiePageSize);
					$("#PageSizeSelectionLinkText").html(pageText).show();
					if (refresh) {
						reBuildListing(customItem);
					}
				}
				// Change pager size on selection and refresh layout

				function changePagerSize(pageSize) {
					var options = {
						path: '/',
						expires: 365
					};
					$.cookie(o.CookiePageSize, pageSize, options);
					window.current_page = o.pagingCurrentPage = 0;
					updatePageSizeOnLayout(true);
				}
				//Handle pager size menu selection

				function handlePageSizeContextMenuEvents(action, el, pos, command) {
					$("#cluetip").hide();
					action = action == "all" ? 0 : action;
					changePagerSize(action);
					return false;
				}
				//Handle context menu of check boxes and various selection options. ie. select files modified today, this week etc

				function handleCheckBoxContextMenuEvents(action, el, pos, command) {
					$("#cluetip").hide();
					switch (action) {
					case 'checkall':
						selectDeselectAllItems(true); // Select all
						break;
					case 'uncheckall':
						selectDeselectAllItems(false); // Deselect all
						break;
					case 'toggle':
						// Toggle
						selectDeselectAllItems(false, true);
						break;
					case 'checkallfiles':
						//Select all Files
						if (currentView() == "Thumbnail") {
							$("#filesContainerDiv").find("li.fileBoxSelected:visible").removeClass("fileBoxSelected");
							$("#filesContainerDiv").find("li.fileThumb:visible").addClass("fileBoxSelected");
						} else {
							$("#filesContainer").find(".chkBox:visible:checked").removeAttr("checked");
							$("#filesContainer").find("td.fileTR").each(function () {
								$(this).parent().find("input.chkBox").attr("checked", "checked");
							});
							if (isChecked($("#filesContainer"))) {
								$("#filesContainer").find("input.chkBoxAll").attr("checked", "checked");
							} else {
								$("#filesContainer").find("input.chkBoxAll").removeAttr("checked");
							}
						}
						break;
					case 'checkallfolders':
						// Select all Folders
						if (currentView() == "Thumbnail") {
							$("#filesContainerDiv").find("li.fileBoxSelected:visible").removeClass("fileBoxSelected");
							$("#filesContainerDiv").find("li.directoryThumb:visible").addClass("fileBoxSelected");
						} else {
							$("#filesContainer").find(".chkBox:visible:checked").removeAttr("checked");
							$("#filesContainer").find("td.directory").each(function () {
								$(this).parent().find("input.chkBox").attr("checked", "checked");
							});
							if (isChecked($("#filesContainer"))) {
								$("#filesContainer").find("input.chkBoxAll").attr("checked", "checked");
							} else {
								$("#filesContainer").find("input.chkBoxAll").removeAttr("checked");
							}
						}
						break;
					case 'checkitemswithdot':
						//Select items start with dot
						if (currentView() == "Thumbnail") {
							$("#filesContainerDiv").find("li.fileBoxSelected:visible").removeClass("fileBoxSelected");
							$("div.imgTitle:visible").find("a").each(

							function () {
								if ($.trim($(this).text()).charAt(0) == ".") {
									$(this).closest("li").addClass("fileBoxSelected");
								}
							});
						} else {
							$("#filesContainer").find(".chkBox:visible:checked").removeAttr("checked");
							$(".jqueryFileTree").find("a").each(

							function () {
								if ($.trim($(this).text()).charAt(0) == ".") {
									$(this).closest("tr").find("input.chkBox").attr("checked", "checked");
								}
							});
							if (isChecked($("#filesContainer"))) {
								$("#filesContainer").find("input.chkBoxAll").attr("checked", "checked");
							} else {
								$("#filesContainer").find("input.chkBoxAll").removeAttr("checked");
							}
						}
						break;
					case 'checktoday':
						//Check items modified in 1 day
						checkModifiedItemsByDay(1);
						break;
					case 'checkweek':
						//Check items modified in 7 days
						checkModifiedItemsByDay(7);
						break;
					case 'checkmonth':
						//Check items modified in 30 days
						checkModifiedItemsByDay(30);
						break;
					case 'check2months':
						//Check items modified in 60 days
						checkModifiedItemsByDay(60);
						break;
					case 'check3months':
						//Check items modified in 90 days
						checkModifiedItemsByDay(90);
						break;
					}
				}
				// Method to check items modified in last n days. For both views

				function checkModifiedItemsByDay(day) {
					day = day || 1;
					if (currentView() == "Thumbnail") {
						$("#filesContainerDiv").find("li.fileBoxSelected:visible").removeClass("fileBoxSelected");
						$("div.imgTitle:visible").find("a").each(

						function () {
							var data = $(this).closest("li").data("dataRow");
							if (data) {
								var fileDateMills = data.fulldate;
								if ((fileDateMills * 1) > new Date().getTime() - (1000 * 60 * 60 * 24 * day)) {
									$(this).closest("li").addClass("fileBoxSelected");
								}
							}
						});
					} else {
						$("#filesContainer").find(".chkBox:visible:checked").removeAttr("checked");
						$(".jqueryFileTree").find("a").each(

						function () {
							var fileDateMills = $(this).closest("tr").attr("modified");
							if ((fileDateMills * 1) > new Date().getTime() - (1000 * 60 * 60 * 24 * day)) {
								$(this).closest("tr").find("input.chkBox").attr("checked", "checked");
							}
						});
						if (isChecked($("#filesContainer"))) {
							$("#filesContainer").find("input.chkBoxAll").attr("checked", "checked");
						} else {
							$("#filesContainer").find("input.chkBoxAll").removeAttr("checked");
						}
					}
				}
				//Handle context menu events

				function handleContextMenuEvents(action, el, pos, command, basket) {
					$("#cluetip").hide();
					if (command) {
						$(document).data("currentContext", {
							'action': action,
							'elem': el,
							'basket' : basket
						});
						command = crushFTPTools.decodeURILocal(command); // Decode command associated with menu and evaluate it
						eval(command);
						clearContext();
					}
					return false;
				}

                if(!String.prototype.shuffle)
                {
                    String.prototype.shuffle = function () {
                        var a = this.split(""),
                            n = a.length;

                        for(var i = n - 1; i > 0; i--) {
                            var j = Math.floor(Math.random() * (i + 1));
                            var tmp = a[i];
                            a[i] = a[j];
                            a[j] = tmp;
                        }
                        return a.join("");
                    }
                }
				// Few prototype entries
				// Add a method "has" to array
				Array.prototype.has = function (value) {
					var i;
					for (var i = 0, loopCnt = this.length; i < loopCnt; i++) {
						if (this[i] === value) {
							return true;
						}
					}
					return false;
				};
				//Add "indexOf" method to array
				if (!Array.prototype.indexOf) {
					Array.prototype.indexOf = function (value) {
						var i;
						for (var i = 0, loopCnt = this.length; i < loopCnt; i++) {
							if (this[i] === value) {
								return i;
							}
						}
						return -1;
					};
				}
				// Array Remove - By John Resig (MIT Licensed)
				Array.prototype.remove = function (from, to) {
					if (this.slice) {
						var rest = this.slice((to || from) + 1 || this.length);
						this.length = from < 0 ? this.length + from : from;
						return this.push.apply(this, rest);
					} else {
						return this;
					}
				}

				//Add Filter method in array if not available
				if (!('filter' in Array.prototype)) {
					Array.prototype.filter= function(filter, that /*opt*/) {
						var other= [], v;
						for (var i=0, n= this.length; i<n; i++)
							if (i in this && filter.call(that, v= this[i], i, this))
								other.push(v);
						return other;
					};
				}
                //Clean array, usage array.clean("");
                Array.prototype.clean = function(deleteValue) {
                  for (var i = 0; i < this.length; i++) {
                    if (this[i] == deleteValue) {
                      this.splice(i, 1);
                      i--;
                    }
                  }
                  return this;
                };

				//Array diff operation
				Array.prototype.diff = function(a) {
					return this.filter(function(i) {return !(a.indexOf(i) > -1);});
				};

				//Finds average numeric value in an array
				Array.prototype.average = function() {
					var av = 0;
					var cnt = 0;
					var len = this.length;
					for (var i = 0; i < len; i++) {
						var e = +this[i];
						if(!e && this[i] !== 0 && this[i] !== '0') e--;
						if (this[i] == e) {av += e; cnt++;}
					}
					return av/cnt;
				}

                Number.prototype.leftZeroPad = function(numZeros) {
                    var n = Math.abs(this);
                    var zeros = Math.max(0, numZeros - Math.floor(n).toString().length );
                    var zeroString = Math.pow(10,zeros).toString().substr(1);
                    if( this < 0 ) {
                            zeroString = '-' + zeroString;
                    }
                    return zeroString+n;
                }

                String.prototype.endsWith = function(str)
                {
                    return (this.match(str+"$")==str);
                }

                $.expr[":"].exacttext = function(obj, index, meta, stack){
                    return (obj.textContent || obj.innerText || $(obj).text() || "").toLowerCase() == meta[3].toLowerCase();
                }

                String.prototype.replaceAll = function(token, newToken, ignoreCase) {
                    var str, i = -1, _token;
                    if((str = this.toString()) && typeof token === "string") {
                        _token = ignoreCase === true? token.toLowerCase() : undefined;
                        while((i = (
                            _token !== undefined?
                                str.toLowerCase().indexOf(
                                            _token,
                                            i >= 0? i + newToken.length : 0
                                ) : str.indexOf(
                                            token,
                                            i >= 0? i + newToken.length : 0
                                )
                        )) !== -1 ) {
                            str = str.substring(0, i)
                                    .concat(newToken)
                                    .concat(str.substring(i + token.length));
                        }
                    }
                return str;
                };

				function availableInBasket(array, file)
				{
					for(var i=0;i<array.length;i++)
					{
						if(unescape(array[i].file) == unescape(file))return true;
					}
					return false;
				}

				window.getItemsFromBasket = function()
				{
					if (!$(document).data(o.BasketDataKey)) { // If basket not avaiable already, create one in document cache
						$(document).data(o.BasketDataKey, new Array());
					}
					return $(document).data(o.BasketDataKey);
				}

				//Add item to basket
				function addToBasket(context) {
					var elem = false;
					var exist = false;
					var _fileName = "";
					if (context) // Select context and set filename to add to the basket
					{
						elem = currentContext();
						if (elem) {
							var $curElem = $(elem);
							_fileName = $curElem.find("a:first").attr("rel");
						}
					}
					var _filePath = "";
					var _root_dir = "";
					var _hasPreview = 0;
					var _dataRow = false;
					var _type = "";
					if (elem) {
						var parentElem = $(elem);
						if (currentView() != "Thumbnail") {
							parentElem = parentElem.closest("tr");
							_type = parentElem.find("td.directory").length>0 ? "DIR" : "FILE";
							_root_dir = parentElem.attr("rootdir");
						}
						else
						{
							_type = parentElem.hasClass("directoryThumb") ? "DIR" : "FILE";
							_root_dir = parentElem.attr("root_dir");
						}
						_filePath = parentElem.find("a").attr("rel");
						_filePath = unescape(_filePath.replace("//", "/"));
						_hasPreview = parentElem.attr("preview");
						_dataRow = parentElem.data("dataRow");
					}
					if (!$(document).data(o.BasketDataKey)) { // If basket not avaiable already, create one in document cache
						$(document).data(o.BasketDataKey, new Array());
					}
					var ItemsInTheBasket = $(document).data(o.BasketDataKey); // Items in the basket
					var selectedFiles = {};
					if (window.listingInfo.selectedEverything) // If all items in the list is selected, loop through them and add to the basket
					{
						var listItems = window.curTreeItems;
						if (window.listingInfo.filtered) {
							listItems = window.matchedItems;
						}
						for (var i = 0; i < listItems.length; i++) {
							var curItem = listItems[i];
							var filePath = unescape(curItem.root_dir) + unescape(curItem.name);
							filePath = filePath.replace("//", "/");
							if(_filePath == filePath)return;
							if (!availableInBasket(ItemsInTheBasket, filePath)) {
								ItemsInTheBasket.push({
									date : curItem.dateFormatted,
									fulldate : curItem.modified,
									keywords : curItem.keywords,
									name : curItem.name,
									preview : curItem.preview,
									privs : curItem.privs,
									size : curItem.sizeFormatted,
									sizeB : curItem.size,
									file : filePath,
									path : curItem.root_dir,
									type : curItem.type
								});
							}
							else
								exist = true;
						}
					} else {
						if (currentView() == "Thumbnail") {
							selectedFiles = $("#filesContainerDiv").find("li.fileBoxSelected:visible");
						} else {
							selectedFiles = $("#filesContainer").find(".chkBox:visible:checked");
						}
						if (selectedFiles.length > 0) {
							selectedFiles.each(function (index) {
								var file = "";
								var hasPreview = 0;
								var dataRow = false;
								var type = "";
								var root_dir = "";
								if (currentView() == "Thumbnail") {
									var _parentElem = $(this).closest("li");
									file = unescape($(this).find("a:first").attr("rel"));
									hasPreview = _parentElem.attr("preview");
									dataRow = _parentElem.data("dataRow");
									type = _parentElem.hasClass("directoryThumb") ? "DIR" : "FILE";
									root_dir = dataRow.root_dir;
								} else {
									var _parentElem = $(this).closest("tr");
									file = unescape(_parentElem.find("a:first").attr("rel"));
									hasPreview = _parentElem.attr("preview");
									dataRow = _parentElem.data("dataRow");
									type = _parentElem.find("td.directory").length>0 ? "DIR" : "FILE";
									root_dir = _parentElem.attr("rootdir");
								}
								if(_filePath == file || !dataRow)return;
								if (!availableInBasket(ItemsInTheBasket, file)) {
									ItemsInTheBasket.push({
										date : dataRow.date,
										fulldate : dataRow.fulldate,
										keywords : dataRow.keywords,
										name : dataRow.name,
										preview : hasPreview,
										privs : dataRow.privs,
										size : dataRow.size,
										path : root_dir,
										sizeB : dataRow.sizeB,
										file : file,
										type : type
									});
								}
								else
								{
									exist = true;
								}
								$(this).click();
							});
						}
						if (!availableInBasket(ItemsInTheBasket, _filePath) && _filePath.length > 0 && _dataRow) { // Only if item not available in the basket, add it
							ItemsInTheBasket.push({
								date : _dataRow.date,
								fulldate : _dataRow.fulldate,
								keywords : _dataRow.keywords,
								name : _dataRow.name,
								preview : _hasPreview,
								privs : _dataRow.privs,
								size : _dataRow.size,
								path : _root_dir,
								sizeB : _dataRow.sizeB,
								file : _filePath,
								type : _type
							});
						}
						else if(_filePath.length > 0)
						{
							exist = true;
						}
					}
					if (ItemsInTheBasket.length > 0) {
						$(document).data(o.BasketDataKey, ItemsInTheBasket);
						rebuildBasket();
						if (currentView() != "Thumbnail") {
							var tbl = $("#filesListing").find("table");
							toggleCheckBoxesAll(tbl, false);
							toggleMainCheckbox(tbl, false);
						}
					}
					if (exist) {
						$("div#filesBasket").dialog("open");
						// Show message if file exist in the basket
						$.growlUI(getLocalizationKey("BasketFileAddedAlreadyText"), getLocalizationKey("BasketFileAddedAlreadyDetailsText"), o.GrowlTimeout, "growlError");
						return;
					} else if(ItemsInTheBasket.length == 0){
						// If nothing to add
						$.growlUI(getLocalizationKey("BasketNothingSelectedToAddText"), getLocalizationKey("BasketNothingSelectedToAddDetailsText"), o.GrowlTimeout, "growlError");
						return;
					}
				}

				//Method to rebuild basket
				window.rebuildBasket = function(items) {
					if (!$(document).data(o.BasketDataKey)) {
						$(document).data(o.BasketDataKey, new Array());
					}
					//Items in the basket
					var ItemsInTheBasket = items || $(document).data(o.BasketDataKey);
					var filesSelectedInBasket = $(".filesSelectedInBasket");
					var curView = currentView(true);
					var basketReopen = false;
					if (curView == "Thumbnail") {
						$("#sliderBasket").show();
						if(filesSelectedInBasket.find("#basketFilesContainerThumb").length==0)
						{
							filesSelectedInBasket.append("<ul id='basketFilesContainerThumb'></ul>");
							zoomInOutView(zoomSliderBasket.slider("value"), false, true);
						}
						else
							basketReopen = true;
						filesSelectedInBasket.find("table").hide();
						filesSelectedInBasket = filesSelectedInBasket.find("ul").empty();
					}
					else
					{
						$("#sliderBasket").hide();
						if($("#basketFilesContainer").length==0)
						{
							filesSelectedInBasket.append("<table id='basketFilesContainer' cellpadding='0' cellspacing='0' class='jqueryFilesTable tablesorter'><thead><tr><td class='thDeleteSelect theader' style='width:25px;'></td><td class='thSelect theader'><input type='checkBox' class='chkBoxAll' /></td><td colName='name' class='thName theader'>" + getLocalizationKey("TreeviewHeaderNameText") + "</td><td  colName='sizeB' class='thSize theader'>" + getLocalizationKey("TreeviewHeaderSizeText") + "</td><td colName='fulldate' class='thModified theader'>" + getLocalizationKey("TreeviewHeaderModifiedText") + "</td><td colName='keywords' class='thKeywords theader'>" + getLocalizationKey("TreeviewHeaderKeywordsText") + "</td></tr></thead></table>");
							setTimeout(function(){
								bindSortingToBasketTreeviewGrid();
							}, 200);
						}
						else
							basketReopen = true;
						filesSelectedInBasket.find("ul").hide();
						filesSelectedInBasket = $("#basketFilesContainer");
						filesSelectedInBasket.find("thead").nextAll().remove();
					}
					filesSelectedInBasket.show();
					var dirs = 0;
					var files = 0;
					//Loop through items and build a list, bind events
					for (var i = 0; i < ItemsInTheBasket.length; i++) {
						if (filesSelectedInBasket.find("*[rel='" + escape(ItemsInTheBasket[i].file) + "']").length == 0) {
							if(ItemsInTheBasket[i].type == "DIR")
								dirs+=1;
							else
								files+=1;
							var newElem = $(generateHTMLForBasketItem(ItemsInTheBasket[i]));
							filesSelectedInBasket.prepend(newElem);
							newElem.data("dataRow", ItemsInTheBasket[i]);
                            var privs = ItemsInTheBasket[i].privs;
                            if(privs.indexOf("(share)")>=0)
                            {
                                if(newElem.find(".chkBox").attr("shareable", "true").length == 0)
                                    newElem.attr("shareable", "true");
                            }
							if (curView == "Thumbnail") {
								loadIconPreview(2, true, newElem, true);
							}
							else {
								loadIconPreview(2, true, newElem.find("td:nth-child(3)"), true);
							}
							vtip(newElem, true);
							newElem.find("span.error").unbind().click(function () {
								if (!$(document).data(o.BasketDataKey)) {
									$(document).data(o.BasketDataKey, new Array());
								}
								var _ItemsInTheBasket = $(document).data(o.BasketDataKey);
								var key = "";
								if (curView == "Thumbnail") {
									key = unescape($(this).closest("li").find("a.imgLink").attr("rel"));
								}
								else
								{
									key = unescape($(this).closest("tr").find("a.imgLink").attr("rel"));
								}
								var deleted = false;
								var items = [];
								for(var i=0;i<_ItemsInTheBasket.length;i++)
								{
									if(unescape(_ItemsInTheBasket[i].file) != key)
									{
										items.push(_ItemsInTheBasket[i]);
									}
									else
										deleted = true;
								}
								if(deleted)
								{
									$(document).data(o.BasketDataKey, items);
									showDownloadBasket(items);
									var parElem = $(this).closest("li");
									if (curView != "Thumbnail") {
										parElem = $(this).closest("tr");
									}
									parElem.fadeOut(100, function () {
										parElem.remove();
										$("#cluetip").hide();
									});
								}
								return false;
							});
						}
					}
					var BasketTotalItemText = getLocalizationKey("BasketTotalItemText");
					BasketTotalItemText = BasketTotalItemText.replace("{0}", ItemsInTheBasket.length);
					var fileBasketList = $("#FileBasketList");
					$(".totalItemCount", fileBasketList).text(BasketTotalItemText + " ("+dirs + " " + getLocalizationKey("FileCounterFoldersText") + " , "+files + " " + getLocalizationKey("FileCounterFilesText") + " )");
					if(window.filteredItemsBasket)
					{
						$(".basketFilterInfo", fileBasketList).text("(Items with phrase \""+window.last_search_item_basket+"\" : "+getLocalizationKey("FileCounterFoldersText")+" : "+window.filteredItemsBasket.dirsCount + " " + getLocalizationKey("FileCounterFilesText") + " : "+window.filteredItemsBasket.filesCount+")");
					}
					else
						$(".basketFilterInfo", fileBasketList).empty();

                    if(!window.disableContextMenuOnBasket)
                    {
    					$(".contextMenuItem", fileBasketList).contextMenu({
    						menu: 'myMenu'
    					}, function (action, el, pos, command) {
    						handleContextMenuEvents(action, el, pos, command, true);
    					});
                    }

					if (curView != "Thumbnail")
					{
						howerEffect(filesSelectedInBasket);
						filesSelectedInBasket.find("tr:even").addClass("jqueryFileTreeAlt");
						bindBasketCheckboxEvents();
						var chkBoxAll = $(".chkBoxAll", filesSelectedInBasket);
						if(chkBoxAll.is(":checked"))
							chkBoxAll.trigger("click").attr("checked", "checked");
						else
							chkBoxAll.trigger("click").removeAttr("checked");

                        if(window.hideKeywordCol)
                        {
                            filesSelectedInBasket.find("td.columnKeywords,td.thKeywords").hide();
                        }
                        if(window.hideModifiedCol)
                        {
                            filesSelectedInBasket.find("td.columnModified, td.thModified").hide();
                        }
                        if(window.hideCheckboxCol)
                        {
                            filesSelectedInBasket.find("td.columnSelect, .chkBoxAll").hide();
                            filesSelectedInBasket.find("thead > tr > td:first").hide();
                        }
                        if(window.hideNameCol)
                        {
                            filesSelectedInBasket.find("td.columnName,td.thName").hide();
                        }
                        if(window.hideSizeCol)
                        {
                            filesSelectedInBasket.find("td.columnSize,td.thSize").hide();
                        }
					}
					else
					{
						$(filesSelectedInBasket).find('LI.fileBoxBasket').unbind("click").click(function (evt) {
							var curitem = $(this);
							var shift = evt.shiftKey || curitem.attr("shift") == "true"; // If shift is pressed it will allow multiple item selection in thumbs view
							curitem.removeAttr("shift");
							if (shift) {
								if (window.lastSelectedItemBasket) // Last selected item, if shift is pressed
								{
									var lastItem = window.lastSelectedItemBasket;
									window.lastSelectedItemBasket = false;
									if (lastItem != curitem) //If current and last items are not same
									{
										var lastItemIndex = $(lastItem).index();
										var curItemIndex = $(curitem).index();
										var isChecked = $($(filesSelectedInBasket).find("li").get(lastItemIndex)).hasClass("fileBoxSelected");

										//loop through items between last selected and current, and apply selection class
										if (lastItemIndex > curItemIndex) {
											for (var i = curItemIndex; i <= lastItemIndex; i++) {
												if ($($(filesSelectedInBasket).find("li").get(i)).is(":visible")) {
													if(isChecked)
														$($(filesSelectedInBasket).find("li").get(i)).addClass("fileBoxSelected");
													else
														$($(filesSelectedInBasket).find("li").get(i)).removeClass("fileBoxSelected");
												}
											}
										}
										//reverse loop if below item selected first
										if (curItemIndex > lastItemIndex) {
											for (var i = lastItemIndex; i <= curItemIndex; i++) {
												if ($($(filesSelectedInBasket).find("li").get(i)).is(":visible")) {
													if(isChecked)
														$($(filesSelectedInBasket).find("li").get(i)).addClass("fileBoxSelected");
													else
														$($(filesSelectedInBasket).find("li").get(i)).removeClass("fileBoxSelected");
												}
											}
										}
									}
								}
							} else {
								//If only single item selection (without shift)
								if (curitem.hasClass("fileBoxSelected")) // If already selected, unselect. Select otherwise
								{
									curitem.removeClass("fileBoxSelected");
								} else {
									curitem.addClass("fileBoxSelected");
								}
								window.lastSelectedItemBasket = curitem;
							}
							// Remove selection range, it messes up UI as all the text came between selection highlights in native browser selection manner
							if (window.getSelection) // Modern Browsers
							{
								var selection = window.getSelection();
								if (selection.removeAllRanges) {
									selection.removeAllRanges();
								}
							}
							if (document.getSelection) // IE
							{
								var selection = document.getSelection();
								if (selection.removeAllRanges) {
									selection.removeAllRanges();
								}
							}
							$(this).blur();
							return false;
						});
					}
					//Show download basket
					showDownloadBasket(ItemsInTheBasket);
					$("#cluetip").hide(); // remove tooltip shown
					if(!basketReopen)
					{
						if (!$("#filterBasket").data("eventAdded")) // bind event of keyup on filter input to do live filter if event not added already
						{
							$("#filterBasket").unbind("keyup").keyup(function (evt) {
								var evt = (evt) ? evt : ((event) ? event : null);
								var val = this.value;

								function startFilter() {
									if (window.last_search_item_basket && window.last_search_item_basket === val) { // if value is not updated, do nothing
										return false;
									}
									setTimeout(function () {
										filterBasketItem(val);
									}, 10);
								}
								if (evt.keyCode == 13) {
									startFilter();
								} else {
									delay(function () {
										startFilter();
									}, 300);
								}
							}).data("eventAdded", true);
							$("a.clearFilterLink", "#filterPanelBasket").unbind("click").click(function(e) {
								e.preventDefault();
								if ($("#filterBasket").val().length > 0) {
									$("#filterBasket").val("").keyup().blur();
									window.last_search_item_basket = false;
								}
								return false;
							});
						}
						//Clear all completed items link event
						$("#submitActionBasket").find(".clearCompleted").unbind().click(function () {
							$(this).blur();
							if (confirm(getLocalizationKey("BasketClearAllConfirmMessage"))) {
								$(document).data(o.BasketDataKey, new Array());
								rebuildBasket();
							}
						});
						//Download link event
						$("#submitActionBasket").find(".download").unbind().click(function () {
							$(this).blur();
							if ($(this).hasClass("advanced")) {
								downloadBasket(null, "applet");
							} else {
								downloadBasket(null, "");
							}
						});
                        //Share items event
                        $("#submitActionBasket").find(".shareBasketItems").unbind().click(function () {
                            $(this).blur();
                            shareFile(false, false, false, false, true);
                        });
					}
					//To download quickly using advanced download
					var quickDLList = $(document).data(o.BasketDataKeyQuickDownload);
					if (quickDLList && quickDLList.length > 0) {
						downloadBasket(null, "applet", true);
					}
				}

				function generateHTMLForBasketItem(opt)
				{
					var fileList = [];
					if (opt) {
						var keywords = unescape(opt.keywords);
						if (keywords.length >= o.keywordsCharLimit) {
							keywords = keywords.substr(
							0, o.keywordsCharLimit) + "...";
						}
						var hideItem = "";
						if(window.filteredItemsBasket)
						{
							if(typeof opt.hide == "undefined")
								hideItem = " ui-helper-hidden";
						}
						if (currentView(true) == "Thumbnail") {
							if (opt.type === 'DIR') {
								var dirTemplate = '<li class="contextMenuItem vtip fileBoxBasket directoryThumb'+hideItem+'" preview="' + opt.preview + '" sizeinbytes="'+opt.sizeB+'"><span class="fileSelectionMark error"></span><span class="fileRemoveFromBasket error"></span><div>' + '<div class="imgBox"><div class="imgWrapper">' + '<table cellspacing="0" cellpadding="0" align="center">' + '<tbody>' + '<tr>' + '<td valign="middle" align="center"><a class="imgLink" rel="' + escape(opt.file) + '" href="javascript:void(0);">' + '<img alt="' + opt.name + '" title="' + opt.name + '" style="border: 0px none;" src="' + o.fileFolder + '"></a></td>' + '</tr>' + '</tbody>' + '</table></div>' + '</div>' + '</div>' + '<div class="imgTitle wordwrap"><a href="javascript:void(0);" rel="'+escape(opt.path)+'" >' + opt.name + '</a></div>' + '</li>';
								fileList.push(dirTemplate);
							} else if (opt.type === 'FILE') {
								var fileTemplate = '<li class="contextMenuItem vtip fileBoxBasket fileThumb'+hideItem+'" preview="' + opt.preview + '" sizeinbytes="'+opt.sizeB+'"><span class="fileSelectionMark error"></span><span class="fileRemoveFromBasket error"></span><div>' + '<div class="imgBox"><div class="imgWrapper">' + '<table cellspacing="0" cellpadding="0" align="center">' + '<tbody>' + '<tr>' + '<td valign="middle" align="center"><a class="imgLink" rel="' + escape(opt.file) + '" href="javascript:void(0);">' + '<img alt="' + opt.name + '" title="' + opt.name + '" style="border: 0px none;" src="' + o.spinerImage + '"></a></td>' + '</tr>' + '</tbody>' + '</table></div>' + '</div>' + '</div>' + '<div class="imgTitle wordwrap"><a href="javascript:void(0);" rel="'+escape(opt.path)+'" >' +  opt.name + '</a></div>' + '</li>';
								fileList.push(fileTemplate);
							}
						} else {
							if (keywords.length >= o.MaximumLengthAllowedForKeywordsString) {
								keywords = keywords.substr(
								0, o.MaximumLengthAllowedForKeywordsString) + "...";
							}
							if (opt.type === 'DIR') {
								fileList.push('<tr rel="' + escape(opt.path) + '" preview="'+ opt.preview +'" class="jqueryFileTree directoryThumb'+hideItem+'"><td><span class="fileRemoveFromBasketTree error" style="margin-top:2px;"></span></td><td class="columnSelect"><input class="chkBox" type="checkbox"/></td><td preview="' + opt.preview + '" class="contextMenuItem directory columnName wordwrap imgTitle" sizeinbytes="'+opt.sizeB+'"><a class="imgLink" rel="' + escape(opt.file) + '" href="javascript:void(0);">' + wbr(opt.name, 30) + '</a></td><td class="columnSize">' + opt.size + '</td><td class="columnModified">' + opt.date + '</td><td class="columnKeywords wordwrap" title="' + keywords + '">' + crushFTPTools.xmlEncode(keywords) + '</td></tr>');
							} else if (opt.type === 'FILE') {
								fileList.push('<tr rel="' + escape(opt.path) + '" preview="'+ opt.preview +'" class="jqueryFileTree'+hideItem+'"><td><span class="fileRemoveFromBasketTree error" style="margin-top:2px;"></span></td><td class="columnSelect"><input class="chkBox" type="checkbox"/></td><td preview="' + opt.preview + '" class="contextMenuItem fileTR columnName fileItem wordwrap imgTitle"sizeinbytes="'+opt.sizeB+'"><a class="imgLink" rel="' + escape(opt.file) + '" href="javascript:void(0);">' + wbr(opt.name, 30) + '</a></td><td class="columnSize">' + opt.size + '</td><td class="columnModified">' + opt.date + '</td><td class="columnKeywords wordwrap" title="' + keywords + '">' + crushFTPTools.xmlEncode(keywords) + '</td></tr>');
							}
						}
					}
					return fileList.join("\r\n");
				}

				//Show download basket
				function showDownloadBasket(ItemsInTheBasket) {
					if (!ItemsInTheBasket) {
						if (!$(document).data(o.BasketDataKey)) {
							$(document).data(o.BasketDataKey, new Array());
						}
						ItemsInTheBasket = $(document).data(o.BasketDataKey);
					}
					var $elem = $("div#filesBasket");
					$(".filesSelectedInBasket", $elem).parent().find(".notificationMsg").remove();
					if (ItemsInTheBasket) {
						if (!ItemsInTheBasket.length || ItemsInTheBasket.length == 0) {
							$(".filesSelectedInBasket", $elem).before("<div class='notificationMsg'>" + getLocalizationKey("BasketNoFilesAvailableText") + "</div>");
							$(".totalItemCount", $elem).empty();
							$("#submitActionBasket").find(".download, .shareBasketItems").hide();
						} else {
							$("#submitActionBasket").find(".download").show();
						}
					} else {
						$(".filesSelectedInBasket", $elem).before("<div class='notificationMsg'>" + getLocalizationKey("BasketNoFilesAvailableText") + "</div>");
						$(".totalItemCount", $elem).empty();
						$("#submitActionBasket").find(".download, .shareBasketItems").hide();
					}
                    setTimeout(function(){
                        var curView = currentView(true);
                        var BasketShareItemsLinkText = $("#BasketShareItemsLinkText");
                        if (curView == "Thumbnail") {
                            if($("#basketFilesContainerThumb").find("li[shareable]").length>0)
                                BasketShareItemsLinkText.show();
                            else
                                BasketShareItemsLinkText.hide();
                        }
                        else
                        {
                            if($("#basketFilesContainer").find("input[shareable]").length>0)
                                BasketShareItemsLinkText.show();
                            else
                                BasketShareItemsLinkText.hide();
                        }
                    }, 200);

					if (!$elem.is(":visible")) {
						$elem.dialog("open");
					}
				}

				//Download basket
				function downloadBasket(elem, opt, quick) {
					if (opt == "") {
						var stringToCopy = "";
						if (!$(document).data(o.BasketDataKey)) {
							$(document).data(o.BasketDataKey, new Array());
						}
                        var hasDir = false;
						var ItemsInTheBasket = $(document).data(o.BasketDataKey);
						for (var i = 0; i < ItemsInTheBasket.length; i++) {
							var filePath = escape(ItemsInTheBasket[i].file);
                            if(ItemsInTheBasket[i].type == "DIR")
                                hasDir = true;
							if (stringToCopy.length > 0) {
								stringToCopy += ":" + filePath;
							} else {
								stringToCopy = filePath;
							}
						};
                        if(ItemsInTheBasket.length>1 || hasDir)
                        {
    						submitAction({
    							'#command': "downloadAsZip",
    							'#path': crushFTPTools.encodeURILocal("/"),
    							'#paths': crushFTPTools.encodeURILocal(unescape(stringToCopy)),
    							'#random': Math.random()
    						});
                        }
                        else
                        {
                            submitAction({
                                '#command': "download",
                                '#path': crushFTPTools.encodeURILocal(unescape(stringToCopy)),
                                '#random': Math.random()
                            });
                        }
					} else { //advanced
						if(quick)
						{
							if(window.quickCalled) {
								return false;
							};
							window.quickCalled = true;
						}
						if (!$(document).data("appletLoaded")) $(document).data("appletLoaded", false);
						if (!$(document).data("appletLoaded")) {
							loadApplet(true, function (pnl) {
								handleAppletBrowse(true, quick);
                                if(!$(".appletNote").is(":visible"))
                                {
                                    window.cancelDropAction(true);
                                }
							}, true);
						} else {
							handleAppletBrowse(true, quick);
						}
					}
				}

				// Method to download selected items quickly using advanced download (java applet)
				function quickAdvancedDownload(context) {
					var elem = false;
					var exist = false;
					var basket = false;
					if (context) {
						elem = currentContext();
						if (elem) {
							var $curElem = $(elem);
							_fileName = $curElem.find("a:first").attr("rel");
							basket = $curElem.hasClass("contextMenuItem");
						}
					}
					var _filePath = "";
					var _hasPreview = 0;
					var _dataRow = false;
					var _type = "";
					var _root_dir = "";
					var items = [];
					if (elem) {
						var parentElem = $(elem);
						if (currentView(basket) != "Thumbnail") {
							parentElem = parentElem.closest("tr");
							_type = parentElem.find("td.directory").length>0 ? "DIR" : "FILE";
							_root_dir = parentElem.attr("rootdir");
						}
						else
						{
							_type = parentElem.hasClass("directoryThumb") ? "DIR" : "FILE";
							_root_dir = parentElem.attr("root_dir");
						}

						_filePath = parentElem.find("a").attr("rel");
						_filePath = unescape(_filePath.replace("//", "/"));
						_hasPreview = parentElem.attr("preview");
						_dataRow = parentElem.data("dataRow");
					}
					var selectedFiles = {};
					var ItemsToDownloadQuick = [];
					var CurrentItemsInTheBasket = $(document).data(o.BasketDataKey);
					CurrentItemsInTheBasket = CurrentItemsInTheBasket || [];
					if (currentView(basket) == "Thumbnail") {
						if(basket)
							selectedFiles = $("#FileBasketList").find("li.fileBoxSelected:visible");
						else
							selectedFiles = $("#filesContainerDiv").find("li.fileBoxSelected:visible");
					} else {
						if(basket)
							selectedFiles = $("#FileBasketList").find(".chkBox:visible:checked");
						else
							selectedFiles = $("#filesContainer").find(".chkBox:visible:checked");
					}
					if (selectedFiles.length > 0) {
						selectedFiles.each(function (index) {
							var file = "";
							var hasPreview = 0;
							var dataRow = false;
							var type = "";
							var root_dir = "";
							if (currentView(basket) == "Thumbnail") {
								var _parentElem = $(this).closest("li");
								file = unescape($(this).find("a:first").attr("rel"));
								hasPreview = _parentElem.attr("preview");
								dataRow = _parentElem.data("dataRow");
								type = _parentElem.hasClass("directoryThumb") ? "DIR" : "FILE";
								root_dir = dataRow.root_dir;
							} else {
								var _parentElem = $(this).closest("tr");
								file = unescape(_parentElem.find("a:first").attr("rel"));
								hasPreview = _parentElem.attr("preview");
								dataRow = _parentElem.data("dataRow");
								type = _parentElem.find("td.directory").length>0 ? "DIR" : "FILE";
								root_dir = _parentElem.attr("rootdir");
							}
							if(_filePath == file || !dataRow)return;
							var curItem = {
								date : dataRow.date,
								fulldate : dataRow.fulldate,
								keywords : dataRow.keywords,
								name : dataRow.name,
								preview : hasPreview,
								privs : dataRow.privs,
								size : dataRow.size,
								sizeB : dataRow.sizeB,
								path : root_dir,
								file : file,
								type : type
							};
							if (!availableInBasket(items, file)) {
								items.push(curItem);
							}
							if (!availableInBasket(ItemsToDownloadQuick, file)) {
								ItemsToDownloadQuick.push(curItem);
							}
							if (!availableInBasket(CurrentItemsInTheBasket, file)) {
								CurrentItemsInTheBasket.push(curItem);
							}
							$(this).click();
						});
					}
					if (!availableInBasket(items, _filePath) && _filePath.length > 0)
					{ // Only if item not available in the basket, add it
						var _curItem = {
							date : _dataRow.date,
							fulldate : _dataRow.fulldate,
							keywords : _dataRow.keywords,
							name : _dataRow.name,
							preview : _hasPreview,
							privs : _dataRow.privs,
							size : _dataRow.size,
							sizeB : _dataRow.sizeB,
							path : _root_dir,
							file : _filePath,
							type : _type
						};
						items.push(_curItem);
						if (!availableInBasket(ItemsToDownloadQuick, _filePath)) {
							ItemsToDownloadQuick.push(_curItem);
						}
						if (!availableInBasket(CurrentItemsInTheBasket, _filePath)) {
							CurrentItemsInTheBasket.push(_curItem);
						}
					}
					if (items.length > 0) {
						$(document).data(o.BasketDataKeyQuickDownload, ItemsToDownloadQuick);
						$(document).data(o.BasketDataKey, CurrentItemsInTheBasket);
						window.quickCalled = false;
						rebuildBasket();
						if (currentView(basket) != "Thumbnail") {
							var tbl = $("#filesListing").find("table");
							toggleCheckBoxesAll(tbl, false);
							toggleMainCheckbox(tbl, false);
						}
					} else if (exist) {
						$.growlUI(getLocalizationKey("BasketFileAddedAlreadyText"), getLocalizationKey("BasketFileAddedAlreadyDetailsText"), o.GrowlTimeout, "growlError");
						return;
					} else {
						$.growlUI(getLocalizationKey("BasketNothingSelectedToAddText"), getLocalizationKey("BasketNothingSelectedToAddDetailsText"), o.GrowlTimeout, "growlError");
						return;
					}
				}

				//Strip down emails
				function stripDownEmails(email) {
					var simpleEmails = "";
					if (email.indexOf(";") < 0) email = email.replace(/,/g, ";");
					var emails = email.split(";");
					for (var x = 0; x < emails.length; x++) {
						var s = emails[x];
						if (s.indexOf("<") >= 0 && s.indexOf(">") >= 0) {
							s = s.substring(s.indexOf("<") + 1, s.indexOf(">"));
						}
						s = $.trim(s); //remove white space
						if (s == "") continue;
						if (s.indexOf("@") > 0 && s.lastIndexOf(".") > s.indexOf("@")) simpleEmails += s + ",";
					}
					if (simpleEmails != "") simpleEmails = simpleEmails.substring(0, simpleEmails.length - 1);
					return simpleEmails;
				}

				//Validate emails
				function validateEmail(email, strict) {
					if (strict) {
						var emails = email.split(";");
						var ok = true;
						var foundOne = false;
						for (var x = 0; x < emails.length; x++) {
							var s = emails[x];
							if (s == "") continue;
							foundOne = true;
							if (s.indexOf("@") > 0 && s.lastIndexOf(".") > s.indexOf("@")) {
								//good email
							} else ok = false;
						}
						if (!foundOne) ok = false;
						return ok;
					} else {
						return email.indexOf("@") > 0 && email.lastIndexOf(".") > email.indexOf("@");
					}
				}

				//Validate share form
				function validateShareForm() {
					var validated = true;
					//Loop through required fields
					if ($("#shareUsername").is(":checked")) {
						$("#shareOptionDiv").find(".validationFail").remove();
						return true;
					}
					$("#shareOptionDiv").find(".required").each(function () {
						var $elm = $(this);
						$elm.parent().find("span.requiredField").remove();
						if (($elm.is("#emailFrom") || $elm.is("#emailTo")) && !$("#sendEmail").is(":checked")) {
							return;
						}
						if ($elm.val().length == 0) {
							if (validated) {
								$elm[0].focus();
							}
							if ($elm.is(".email")) {
								$elm.after(" <span class='requiredField'>* <img src='" + o.ImageFilePath + "help.png'  alt='help' title='" + getLocalizationKey("ShareActionEmailValidationFailureHelpToolTip") + "' /></span>");
								$elm.next().find("img").cluetip({
									splitTitle: '^',
									showTitle: false,
									width: 300,
									cluetipClass: 'default-ontop',
									positionBy: 'mouse',
									mouseOutClose: true,
									dropShadowSteps: 0,
									onShow: function () {
										$("#cluetip").css("z-index", "9999").css("width", "320px");
										var _offset = $elm.next().find("img").offset();
										var _left = _offset.left;
										if (_left) {
											$("#cluetip").css("left", _left + 20 + "px");
										}
									}
								});
							} else {
								$elm.after(" <span class='requiredField'>*</span>");
							}
							validated = false;
						}
					});
					//Validate emails
					$("#shareOptionDiv").find(".email").each(function () {
						var $elm = $(this);
						if ($elm.parent().find("span.requiredField").length > 0 || (($elm.is("#emailFrom") || $elm.is("#emailTo") || $elm.is("#emailCc") || $elm.is("#emailBcc")) && !$("#sendEmail").is(":checked"))) {
							return;
						}
						var val = $elm.val();
						val = $.trim(val);
						if (val.length > 0) {
							val = stripDownEmails(val);
							//if we are sharing to usernames, we don't validate anything. //TODO
							if (!validateEmail(val, true)) {
								$elm.after(" <span class='requiredField'>* <img src='" + o.ImageFilePath + "help.png'  alt='help' title='" + getLocalizationKey("ShareActionEmailValidationFailureHelpToolTip") + "' /></span>");
								$elm.next().find("img").cluetip({
									splitTitle: '^',
									showTitle: false,
									width: 300,
									cluetipClass: 'default-ontop',
									positionBy: 'mouse',
									mouseOutClose: true,
									dropShadowSteps: 0,
									onShow: function () {
										$("#cluetip").css("z-index", "9999").css("width", "320px");
										var _offset = $elm.next().find("img").offset();
										var _left = _offset.left;
										if (_left) {
											$("#cluetip").css("left", _left + 20 + "px");
										}
									}
								});
								validated = false;
							}
						}
					});
					$("#shareOptionDiv").find(".validationFail").remove();
					if (!validated) {
						$("table", "#shareOptionDiv").before("<div style='padding:5px;margin:5px 0px; color:red;' class='validationFail'>" + getLocalizationKey("FormValidationFailText") + "</div>");
					}
					return validated;
				}

                function downloadSyncApp(appName)
                {
                    appName = appName || localizations.syncAppName || "CrushSync";
                    $("#syncAppNamePanel").remove();
                    var promptTemplate = "<div class='syncAppNamePanel'><h2>" + getLocalizationKey("SyncAppNameWindowHeaderText") + "</h2><br><div style='text-align:left;'>"+getLocalizationKey("SyncAppDownloadYourPassText")+"<input type='password' class='currentPass' style='width:300px;' /><br><div style='text-align:left;'>"+getLocalizationKey("SyncAppDownloadAdminPassText")+"<input type='password' class='appName' style='width:300px;' /><br><div class='cancelButton' style='float:right;margin-left:10px;'>" + getLocalizationKey("SyncAppNamePanelCancelLinkText") + "</div><div class='saveButton' style='float:right;'>" + getLocalizationKey("SyncAppNamePanelSaveLinkText") + "</div></div></div>";
                    $("body").append("<div id='syncAppNamePanel'>" + promptTemplate + "</div>");
                    var $NameBox = $("#syncAppNamePanel").hide();
                    $.blockUI({
                        message: $NameBox,
                        css: {
                            padding: '10px 10px 20px 30px',
                            'background-color': getPopupColor(true),
                            'border': "1px solid " + getPopupColor(),
                            '-webkit-border-radius': '10px',
                            '-moz-border-radius': '10px',
                            color: '#000',
                            opacity: 0.9,
                            top: 100,
                            left: '40%',
                            width: '305px'
                        },
                        onBlock : function()
                        {
                            $NameBox.parent().css("top","200px");
                            if($("div#filesBasket").dialog("isOpen"))
                            {
                                $(".blockOverlay").css("z-index", "1002");
                                $(".blockMsg").css("z-index", "1003");
                                $("div#filesBasket").parent().css("z-index", "1001");
                            }
                        },
                        onUnblock : function()
                        {
                            if($("div#filesBasket").dialog("isOpen"))
                            {
                                $("div#filesBasket").parent().css("z-index", "1003");
                            }
                        }
                    });
                    $NameBox.find(".currentPass").val("").focus();
                    $NameBox.find(".cancelButton").unbind().click(
                       function () {
                            $.unblockUI();
                            $("#syncAppNamePanel").remove();
                            if($("div#filesBasket").dialog("isOpen"))
                            {
                                $("div#filesBasket").parent().css("z-index", "1003");
                            }
                    });
                    $NameBox.find(".saveButton").unbind().click(
                    function () {
                        var newName =  crushFTPTools.encodeURILocal($NameBox.find(".appName").val());
                        var curPass = crushFTPTools.encodeURILocal($NameBox.find(".currentPass").val());
                        submitAction({
                            '#command': "downloadSyncAgent",
                            '#appname' : appName,
                            '#admin_pass': newName,
                            '#current_password': curPass,
                            '#random': Math.random()
                        });
                        $.growlUI(getLocalizationKey("DownloadStartedAlertTitleText"), getLocalizationKey("DownloadStartedAlertDescText"), o.GrowlTimeout);
                        if($("div#filesBasket").dialog("isOpen"))
                        {
                            $("div#filesBasket").parent().css("z-index", "1003");
                        }
                    });
                    $NameBox.find(".appName").unbind().keyup(
                    function (evt) {
                        var evt = (evt) ? evt : ((event) ? event : null);
                        if (evt.keyCode == 13) {
                            $NameBox.find(".saveButton").click();
                            return false;
                        } else if (evt.keyCode == 27) {
                            $NameBox.find(".cancelButton").click();
                            return false;
                        }
                    });
                }

                function downloadCrushFTPDrive(appName)
                {
                    appName = appName || localizations.crushFTPDriveName || "CrushFTPDrive";
                    submitAction({
                        '#command': "downloadCrushFTPDrive",
                        '#appname' : appName,
                        '#random': Math.random()
                    });
                    $.growlUI(getLocalizationKey("DownloadStartedAlertTitleText"), getLocalizationKey("DownloadStartedAlertDescText"), o.GrowlTimeout);
                }

				//Start media preview
				function mediaPreview(context, ignoreExtension)
				{
					var $elem = $("#mediaPreviewDiv");
					var mediaPreviewCloseButton = $("#mediaPreviewCloseButton", $elem);
					mediaPreviewCloseButton.unbind().bind("click", function(){
						$elem.find("div.content").empty();
						setTimeout(function(){
							$.unblockUI();
						}, 100);
					})
					var el = false;
					var basket = false;
					if (context) {
						el = currentContext();
						if(el)
							basket = el.hasClass("contextMenuItem");
					}
					if(!el)
					{
						if(basket)
						{
							if (currentView(basket) == "Thumbnail") {
								el = $("#FileBasketList").find("li.fileBoxSelected:visible:first");
							}
							else {
								el = $("#FileBasketList").find("input.chkBox:visible:checked:first").parent().next();
							}
						}
						else
						{
							if (currentView() == "Thumbnail") {
								el = $("#filesContainerDiv").find("li.fileBoxSelected:visible:first");
							}
							else {
								el = $("#filesListing").find("input.chkBox:visible:checked:first").parent().next();
							}
						}
					}
					if (!el || el.length == 0) {
						$.growlUI(getLocalizationKey("PreviewNothingSelectedGrowlText"), "&nbsp;", o.GrowlTimeout, "growlError");
						return;
					}
					var _fileName = "";
					if (el) {
						_fileName = unescape($(el).find("a:first").attr("rel"));
					}
					var getFileExtension = function(filename) {
						var ext = /^.+\.([^.]+)$/.exec(filename);
						return ext == null ? "" : ext[1].toLowerCase();
					}
					ext = getFileExtension(_fileName);
					var preview = false;
					if(ext.length>0)
					{
						if(window.mediaFileExtensions.has(ext))
						{
							preview = true;
						}
					}
					if(preview || ignoreExtension)
					{
						$.blockUI({
							message: $elem,
							css: {
								width: '720px',
								padding: '15px',
								'margin-left': '-365px',
								left: '50%',
								position: 'absolute',
								top: '15%',
								'-webkit-border-radius': '10px',
								'-moz-border-radius': '10px',
								opacity: 1,
								'background-color': getPopupColor(true),
								'border': "1px solid " + getPopupColor()
							},
							onBlock: function () {
								$elem.parent().draggable({
									handle: "h2"
								});
								var content = $elem.find("div.content").empty();
								content.append(getLocalizationKey("loadingIndicatorText"));
								setTimeout(function(){
									var ext = getFileExtension(_fileName);
									var mimeType = mimeTypes[ext] || mimeTypes["*"];
									var path = o.downloadURL + "?command=download&random="+Math.random()+"&mimeType="+mimeType + "&CrushAuth=" + $.cookie("CrushAuth")+"&path="+crushFTPTools.decodeURILocal(_fileName).replace(/\&/g, "%26");
									if(ext == "flv")
									{
										content.empty().append("<a href=\""+path+"\" class=\"media {flashvars: { flv: '"+crushFTPTools.encodeURILocal(path)+"'}, width:700, height:500}\">Preview : \""+ _fileName.replace(/\&/g, "%26") +"\"</a> ");
										content.find("a.media").media({
											params :{
												movie : o.FilePath + 'js/player_flv_maxi.swf',
												autoplay : '1',
												autoload : '1',
												showstop : '1',
												showvolume : '1',
												showtime : '2',
												showplayer : 'always',
												showloading : 'always',
												showfullscreen : '1'
											}
										});
									}
									else if(ext == "mp3")
									{
                                        if(window.useHTML5PlayerWhenAvailable && !!document.createElement('video').canPlayType)
                                        {
                                            content.empty().append("<div id='mediaPlayerElement'></div>");
                                            var mPlayer = content.find("#mediaPlayerElement");
                                            mPlayer.append('<audio tabindex="0" width="500" height="40"><source type="audio/mp3" src="'+(path)+'"></audio><div>Preview : "'+ _fileName +'"</div>    ');
                                            mPlayer.find("audio").acornMediaPlayer({theme: 'access', nativeSliders: true});
                                        }
                                        else
                                        {
    										content.empty().append("<a href=\""+path+"\" class=\"media {flashvars: { mp3: '"+escape(path)+"'}, width:700, height:60}\">Preview : \""+ _fileName.replace(/\&/g, "&amp;") +"\"</a> ");
    										content.find("a.media").media({
    											params :{
    												movie : o.FilePath + "js/player_mp3_maxi.swf",
    												showstop : 1,
    												showinfo : 1,
    												showvolume : 1
    											}
    										});
                                        }

									}
									else if(ext == "swf")
									{
										content.empty().append("<a href=\""+path+"\" class=\"media {width:700, height:500, type:'swf'}\">Preview : \""+ _fileName +"\"</a> ");
										content.find("a.media").media();
									}
									else
									{
                                        if(window.useHTML5PlayerWhenAvailable && !!document.createElement('video').canPlayType("video/"+ext+"") && (ext == "mp4" || ext == "webm" || ext == "ogg"))
                                        {
                                            content.empty().append("<div id='mediaPlayerElement'></div>");
                                            var mPlayer = content.find("#mediaPlayerElement");
                                            var is_chrome = navigator.userAgent.indexOf('Chrome') > -1;
                                            var _ext = is_chrome ? "webm" : ext;
                                            mPlayer.append('<video tabindex="0" width="700" height="500"><source type="video/'+_ext+'" src="'+(path)+'"></video><div>Preview : "'+ _fileName +'"</div>    ');
                                            mPlayer.find("video").acornMediaPlayer({theme: 'access', nativeSliders: true});
                                        }
                                        else
                                        {
                                            if(ext == "ogg")
                                            {
                                                $.unblockUI();
                                                growl("Preview not supported", "Your browser does not support previewing this file", true, 3500);
                                            }
                                            else
                                            {
                                                content.empty().append("<a href=\""+path+"\" class=\"media {width:700, height:500}\">Preview : \""+ _fileName +"\"</a> ");
                                                content.find("a.media").media({
                                                    params :{
                                                        showcontrols : '1',
                                                        showpositioncontrols : '1',
                                                        showaudiocontrols : '2',
                                                        showstatusbar : '1',
                                                        showfullscreen : '1',
                                                        autosize : '1',
                                                        uiMode : 'full',
                                                        scale : 'aspect',
                                                        kioskmode : 'true'
                                                    }
                                                });
                                            }
                                        }
									}
									if($("div#filesBasket").dialog("isOpen"))
										$(".blockMsg").css("z-index", 1002);
								}, 100);
							}
						});
					}
					else
					{
						$.growlUI(getLocalizationKey("NoPreviewGrowlText"), getLocalizationKey("NoPreviewGrowlDesc"), o.GrowlTimeout, "growlError");
						return;
					}
				}
				//Change icon of selected files
				function changeIcon(context)
				{
					var el = false;
					var basket = false;
					if (context) {
						el = currentContext();
						if(el)
							basket = el.hasClass("contextMenuItem");
					}
					var _fileName = "";
					if (el) {
						_fileName = unescape($(el).find("a:first").attr("rel"));
					}
					var $elem = $("#iconChangeDiv");
					$.blockUI({
						message: $elem,
						css: {
							width: '400px',
							padding: '15px',
							'margin-left': '-200px',
							left: '50%',
							position: 'absolute',
							top: '27%',
							'-webkit-border-radius': '10px',
							'-moz-border-radius': '10px',
							opacity: 1,
							'background-color': getPopupColor(true),
							'border': "1px solid " + getPopupColor()
						},
						onBlock: function(){
							$elem.find("input.variable").val("");
							var rootPath = "";
							if (currentView(basket) != "Thumbnail") {
								rootPath = $(el).closest("tr").attr("rel");
							}
							else {
								rootPath = $(el).find("div.imgTitle").find("a").attr("rel");
							}
							$elem.find("input#uploadPath").val(rootPath);
							$elem.find("input#changeIconItem").val(_fileName);
							$("#changeIconWindowSelectedFiles", $elem).html("<br />" + _fileName + "<br/>");
						}
					});
					if($("div#filesBasket").dialog("isOpen"))
						$(".blockMsg").css("z-index", 1002);
					$("a.cancel", $elem).unbind().click(function () {
						$.unblockUI();
					});
					$("a.update", $elem).unbind().click(function () {
						if($elem.find("input[type='file']").val()=="")
						{
							alert(getLocalizationKey("ChangeIconFileSelectAlertText"));
							return false;
						}
						else
						{
							$("#iframeUploadIcon").unbind().bind("load", function(){
								refreshPreivewIcon(el);
							});
							$elem.find("form").submit();
							$.unblockUI();
							selectDeselectAllItems(false, false, basket);
						}
					});
				}

				function refreshPreivewIcon(el)
				{
					$(el).attr("preview","1");
					if (currentView() == "Thumbnail") {
						var _title = $(el).attr("title");
						var fileLink = $(el).find("a.imgLink");
						var filePath = fileLink.attr("href");
						if(_title.indexOf("command=getPreview")>=0)
						{
							_title = _title.replace("command=getPreview", "command=getPreview&random=" + Math.random());
						}
						else
						{
							_title = "<img src=\"" + o.ajaxCallURL + "?command=getPreview&size=3&path=" + crushFTPTools.encodeURILocal(unescape(filePath)) + "&random="+Math.random()+"&frame=1" + "\" border=\"0\" />" + _title;
						}
						$(el).attr("title", _title);
						vtip($(el));
					}
					zoomInOutView(zoomSlider.slider("value"), el);
				}

                window.quickShareFile = function(context, files, multiple, fileNames)
                {
                    var el = false;
                    var basket = false;
                    if (context) {
                        el = currentContext();
                        if(el)
                            basket = el.hasClass("contextMenuItem");
                    }
                    var _fileName = "";
                    if (el) {
                        _fileName = unescape($(el).find("a:first").attr("rel"));
                    }
                    var fileName = _fileName;
                    var multipleFiles = false;
                    var fileNameOnly = "";
                    if(files)
                    {
                        fileName = files;
                        multipleFiles = multiple;
                        fileNameOnly = fileNames;
                    }
                    else
                    {
                        fileNameOnly = _fileName.substring(_fileName.lastIndexOf("/", _fileName.length - 2) + 1) + "\r\n";
                        var selectedFiles = [];
                        var itemList = [];
                        //If everything is selecetd, share a folder
                        if (window.listingInfo.selectedEverything) {
                            var listItems = window.curTreeItems;
                            if (window.listingInfo.filtered) {
                                listItems = window.matchedItems;
                            }
                            for (var i = 0; i < listItems.length; i++) {
                                var curItem = listItems[i];
                                if (!itemList.has(curItem.name)) {
                                    itemList.push(curItem.name);
                                    fileName += curItem.name;
                                    fileNameOnly += curItem.name.substring(curItem.name.lastIndexOf("/", curItem.name.length - 2) + 1) + "\r\n";
                                    if (i + 1 < listItems.length) {
                                        fileName += "\r\n";
                                    }
                                }
                            }
                        } else {
                            //Else select chosen items
                            if(basket)
                            {
                                if (currentView(basket) == "Thumbnail") {
                                    selectedFiles = $("#FileBasketList").find("li.fileBoxSelected:visible");
                                } else {
                                    selectedFiles = $("#FileBasketList").find("input.chkBox:visible:checked");
                                }
                            }
                            else
                            {
                                if (currentView() == "Thumbnail") {
                                    selectedFiles = $("#filesContainerDiv").find("li.fileBoxSelected:visible");
                                } else {
                                    selectedFiles = $("#filesListing").find("input.chkBox:visible:checked");
                                }
                            }
                            if (selectedFiles.length > 0) {
                                fileName = _fileName + "\r\n";
                                selectedFiles.each(function (index) {
                                    var file = "";
                                    if (currentView(basket) != "Thumbnail") {
                                        file = unescape($(this).closest("tr").find("a:first").attr("rel"));
                                    } else {
                                        file = unescape($(this).find("a:first").attr("rel"));
                                    }
                                    if (file != _fileName && !itemList.has(file)) {
                                        itemList.push(file);
                                        fileName += file;
                                        fileNameOnly += file.substring(file.lastIndexOf("/", file.length - 2) + 1) + "\r\n";
                                        if (index + 1 < selectedFiles.length) {
                                            fileName += "\r\n";
                                        }
                                    }
                                });
                            }
                            if (selectedFiles.length > 1) {
                                multipleFiles = true;
                            }
                        }
                    }
                    var destinationPath = unescape(window.location.toString()).replace(hashListener.getHash().toString(), "");
                    performShareFormSubmit(destinationPath, fileName, true, fileNameOnly);
                }

				//Share files
				window.shareFile = function(context, files, fileNames, multiple, fromBasket) {
					var el = false;
					var basket = false;
					if (context) {
						el = currentContext();
						if(el)
							basket = el.hasClass("contextMenuItem");
					}
                    var isFolder = false;
                    if(el && el.length>0)
                    {
                        if(!el.hasClass("fileTR") && !el.hasClass("fileThumb"))
                            isFolder=true;
                    }
                    if(fromBasket)
                        basket = true;
					$("#shareOptionDiv").html($("#shareOptionDiv").data("html"));
					//Apply share window customizations
					applyShareCustomizations();

					//Set mask to time field
					$("#txtTime", "#shareOptionDiv").setMask("29:59").keypress(function () {
						var currentMask = $(this).data('mask').mask;
						var newMask = $(this).val().match(/^2.*/) ? "23:59" : "29:59";
						if (newMask != currentMask) {
							$(this).setMask(newMask);
						}
					});
					var monthNames = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
                    //Set mask to day field
                    $("#txtdays", "#shareOptionDiv").setMask("9999").keyup(function () {
                        var days = parseInt($(this).val());
                        if (days == NaN) days = 0;
                        if (days > 0) {
                            var myDate = new Date();
                            myDate.setDate(myDate.getDate() + days);
                            var prettyDate = (myDate.getMonth() + 1) + '/' + myDate.getDate() + '/' + myDate.getFullYear();
                            $("#txtDate", "#shareOptionDiv").val(prettyDate).attr("date", prettyDate);
                            if (window.Shareyyyymmdd) {
								prettyDate = myDate.getFullYear() + '/' + monthNames[myDate.getMonth()] + '/' + myDate.getDate();
								$("#txtDate", "#shareOptionDiv").val(prettyDate);
							}
                            if (window.Shareddmmyyyy) {
                                var mnth = myDate.getMonth() + 1;
                                prettyDate = myDate.getDate() + '/' + mnth.leftZeroPad(2) + '/' + myDate.getFullYear();
                                $("#txtDate", "#shareOptionDiv").val(prettyDate);
                            }
						}
					});
					var days = parseInt($("#txtdays", "#shareOptionDiv").val());
					if (days == NaN) days = 0;
					var myDate = new Date();
					myDate.setDate(myDate.getDate() + days);
					var prettyDate = (myDate.getMonth() + 1) + '/' + myDate.getDate() + '/' + myDate.getFullYear();
					$("#txtDate", "#shareOptionDiv").val(prettyDate).attr("date", prettyDate);
					if (window.Shareyyyymmdd) {
						prettyDate = myDate.getFullYear() + '/' + monthNames[myDate.getMonth()] + '/' + myDate.getDate();
					}
                    if (window.Shareddmmyyyy) {
                        var mnth = myDate.getMonth() + 1;
                        prettyDate = myDate.getDate() + '/' + mnth.leftZeroPad(2) + '/' + myDate.getFullYear();
                    }
					var _nowDate = new Date();
					_nowDate.setDate(_nowDate.getDate() + 1);
					var _dateFormat = 'mm/dd/yy';
					if (window.Shareyyyymmdd) {
						_dateFormat = 'yyyy/MM/dd';
					}
                    if (window.Shareddmmyyyy) {
                        _dateFormat = 'dd/MM/yyyy';
                    }
					//Date picker
					$("#txtDate", "#shareOptionDiv").val(prettyDate).datepicker({
						dateFormat: _dateFormat,
						showOn: 'both',
						buttonImage: '/WebInterface/jQuery/images/calendar.png',
						buttonImageOnly: true,
						minDate: _nowDate
					}).change(function () {
						//Calculate date and time and show in days field
						var selectedDate = $(this).datepicker("getDate").getTime();
						var nowDate = new Date();
						nowDate.setDate(nowDate.getDate() - 1);
						nowDate = nowDate.getTime();
						var diff = new Date();
						diff.setTime(Math.abs(selectedDate - nowDate));
						var timediff = diff.getTime();
						var days = Math.floor(timediff / (1000 * 60 * 60 * 24));
						$("#txtdays", "#shareOptionDiv").val(days);
						var myDate = new Date();
						myDate.setDate(myDate.getDate() + days);
						var prettyDate = (myDate.getMonth() + 1) + '/' + myDate.getDate() + '/' + myDate.getFullYear();
						$("#txtDate", "#shareOptionDiv").val(prettyDate).attr("date", prettyDate);
						if (window.Shareyyyymmdd) {
							prettyDate = myDate.getFullYear() + '/' + monthNames[myDate.getMonth()] + '/' + myDate.getDate();
							$("#txtDate", "#shareOptionDiv").val(prettyDate);
						}
                        if (window.Shareddmmyyyy) {
                            var mnth = myDate.getMonth() + 1;
                            prettyDate = myDate.getDate() + '/' + mnth.leftZeroPad(2) + '/' + myDate.getFullYear();
                            $("#txtDate", "#shareOptionDiv").val(prettyDate);
                        }
					});
					//Default values and show fields based on values
					if ($("input#advanced", "#shareOptionDiv").is(":checked")) {
						$(".advanced", "#shareOptionDiv").show();
					} else {
						$(".advanced", "#shareOptionDiv").hide();
					}
					$("input#advanced", "#shareOptionDiv").click(function () {
						if ($(this).is(":checked")) {
							$(".advanced", "#shareOptionDiv").show();
						} else {
							$(".advanced", "#shareOptionDiv").hide();
						}
					});
					$(".enterpriseFeature").hide();
					if ($(document).data("crushftp_enterprise")) { //show enterprise features..some of these are in sharing panel
						$(".enterpriseFeature").show();
					}
                    else
                    {
                        $(".enterpriseFeature").remove();
                    }

					if ($("input#shareUsername", "#shareOptionDiv").is(":checked")) {
						$(".notShareUsername", "#shareOptionDiv").hide();
						$(".isShareUsername", "#shareOptionDiv").show();
					} else {
						$(".notShareUsername", "#shareOptionDiv").show();
						$(".isShareUsername", "#shareOptionDiv").hide();
					}

                    $("input#shareUsername", "#shareOptionDiv").change(function () {
						if ($(this).is(":checked")) {
							$(".notShareUsername", "#shareOptionDiv").hide();
							$(".isShareUsername", "#shareOptionDiv").show();
						} else {
							$(".notShareUsername", "#shareOptionDiv").show();
							$(".isShareUsername", "#shareOptionDiv").hide();
						}
					});

                    $("input#externalUser", "#shareOptionDiv").change(function () {
                       $("input#shareUsername", "#shareOptionDiv").trigger("change");
                    });

					var _fileName = "";
					if (el) {
						_fileName = unescape($(el).find("a:first").attr("rel"));
					}
					var fileName = _fileName;
                    var multipleFiles = false;
                    var fileNameOnly = "";
                    if(files)
                    {
                        fileName = files;
                        multipleFiles = multiple;
                        fileNameOnly = fileNames;
                    }
                    else
                    {
    					fileNameOnly = _fileName.substring(_fileName.lastIndexOf("/", _fileName.length - 2) + 1) + "\r\n";
    					var selectedFiles = [];
    					var itemList = [];
    					//If everything is selecetd, share a folder
    					if (window.listingInfo.selectedEverything) {
                            isFolder = true;
    						var listItems = window.curTreeItems;
    						if (window.listingInfo.filtered) {
    							listItems = window.matchedItems;
    						}
    						for (var i = 0; i < listItems.length; i++) {
    							var curItem = listItems[i];
    							if (!itemList.has(curItem.name)) {
    								itemList.push(curItem.name);
    								fileName += curItem.name;
    								fileNameOnly += curItem.name.substring(curItem.name.lastIndexOf("/", curItem.name.length - 2) + 1) + "\r\n";
    								if (i + 1 < listItems.length) {
    									fileName += "\r\n";
    								}
    							}
    						}
    					} else {
    						//Else select chosen items
    						if(basket)
    						{
    							if (currentView(basket) == "Thumbnail") {
    								selectedFiles = $("#FileBasketList").find("li.fileBoxSelected:visible[shareable]");
    							} else {
    								selectedFiles = $("#FileBasketList").find("input.chkBox:visible:checked[shareable]");
    							}
    						}
    						else
    						{
    							if (currentView() == "Thumbnail") {
    								selectedFiles = $("#filesContainerDiv").find("li.fileBoxSelected:visible");
    							} else {
    								selectedFiles = $("#filesListing").find("input.chkBox:visible:checked");
    							}
    						}
    						if (selectedFiles.length > 0) {
                                if(_fileName.length>0)
    							 fileName = _fileName + "\r\n";
    							selectedFiles.each(function (index) {
    								var file = "";
    								if (currentView(basket) != "Thumbnail") {
                                        {
                                            var prnt = $(this).closest("tr");
        									file = unescape(prnt.find("a:first").attr("rel"));
                                            if(prnt.find(".fileTR").length==0)
                                                isFolder=true;
                                        }
    								} else {
    									file = unescape($(this).find("a:first").attr("rel"));
                                        if(!$(this).hasClass("fileThumb"))
                                            isFolder=true;
    								}
    								if (file != _fileName && !itemList.has(file)) {
    									itemList.push(file);
    									fileName += file;
    									fileNameOnly += "\r\n" + crushFTPTools.htmlEncode(file.substring(file.lastIndexOf("/", file.length - 2) + 1)) + "\r\n";
    									if (index + 1 < selectedFiles.length) {
    										fileName += "\r\n";
    									}
    								}
    							});
    						}
    						if (selectedFiles.length > 1) {
    							multipleFiles = true;
    						}
    					}
                    }
					var destinationPath = unescape(window.location.toString()).replace(hashListener.getHash().toString(), "");
					if (fileName.length == 0) {
						$.growlUI(getLocalizationKey("ShareNothingSelectedGrowlText"), getLocalizationKey("NothingSelectedGrowlText"), o.GrowlTimeout, "growlError");
						return;
					}
					performAction("shareOptionDiv");
					if($("div#filesBasket").dialog("isOpen"))
                    {
						$(".blockMsg").css("z-index", 1005);
                        $.cssRule({
                            ".blockMsg": [
                                ["z-index", "1005 !important"]
                                ]
                        });
                    }
					if (!window.shareEmailBody) window.shareEmailBody = $("#emailBody").val();
					if (o.buggyBrowser) {
						window.shareEmailBody = window.shareEmailBody.replace(/([^>\r\n]?)(\r\n|\n\r|\r|\n)/g, '$1\r$2');
					}
					var emailBody = $("#emailBody").val(window.shareEmailBody.replace(/{files}/g, fileNameOnly)).htmlarea({
                        toolbar: [
                                "bold", "italic", "underline",
                                "|",
                                "h1", "h2", "h3",
                                "|",
                                "orderedList", "unorderedList",
                                "|",
                                "justifyleft", "justifycenter", "justifyright",
                                "|",
                                "forecolor",
                                "|",
                                "image",
                                "|",
                                "link", "unlink",
                                "|",
                                "increasefontsize", "decreasefontsize",
                                "|",
                                "html"
                            ],
                        css : "/WebInterface/Resources/css/jHtmlArea/editor.css"
                    });
                    if(emailBody.attr("readonly"))
                    {
                        emailBody.htmlarea('dispose');
                    }
                    var directLink = $("#frmShareWindow").find(".directLink").hide();
					if (multipleFiles) {
						$("legend", "#shareOptionDiv").html(getLocalizationKey("ShareWindowHeaderText"));
					} else {
						if (fileName.length >= o.MaximumLengthAllowedForSharingPopupHeaderString) {
							$("legend", "#shareOptionDiv").html(fileName.substr(0, o.MaximumLengthAllowedForSharingPopupHeaderString) + "...");
						} else {
							$("legend", "#shareOptionDiv").html(fileName);
						}
                        if(!isFolder)
                        {
                            if(typeof window.shareWindowDisableDirectLinkForFile != "undefined")
                            {
                                if(!window.shareWindowDisableDirectLinkForFile)
                                    directLink.show();
                            }
                            else
                                directLink.show();
                        }
					}
                    window.directLinkonShare = directLink.is(":visible");
					$("#txtFilesToShare").html(fileName);
					$("#btnSubmitShareAction", "#shareOptionDiv").click(function () {
						performShareFormSubmit(destinationPath, fileName);
						return false;
					});
					var shareThumbnail = $(document).data("shareThumbnail");
					if (shareThumbnail) {
						if (shareThumbnail == "true") {
							$("#shareOptionDiv").find("input#attach").attr("checked", "checked");
						} else {
							$("#shareOptionDiv").find("input#attach").removeAttr("checked");
						}
					}
					var shareAllowUploads = $(document).data("shareAllowUploads");
					if (shareAllowUploads) {
						if (shareAllowUploads == "true") {
							$("#shareOptionDiv").find("input#fullaccess").attr("checked", "checked");
							$("#shareOptionDiv").find("input#advanced").attr("checked", "checked").click();
							$("#shareOptionDiv").find("input#advanced").attr("checked", "checked");
						}
					}
					var shareAdvanced = $(document).data("shareAdvanced");
					if (shareAdvanced) {
						if (shareAdvanced == "true") {
							$("#shareOptionDiv").find("input#advanced").attr("checked", "checked").click();
							$("#shareOptionDiv").find("input#advanced").attr("checked", "checked");
						} else {
							$("#shareOptionDiv").find("input#advanced").removeAttr("checked").click();
							$("#shareOptionDiv").find("input#advanced").removeAttr("checked");
						}
					}
					var defaultShareMethod = $(document).data("defaultShareMethod");
					if (defaultShareMethod) {
						defaultShareMethod = defaultShareMethod.toLowerCase();
						if (defaultShareMethod == "copy") {
							$("#shareOptionDiv").find("input#chkCopy").attr("checked", "checked");
						} else if (defaultShareMethod == "reference") {
							$("#shareOptionDiv").find("input#chkReference").attr("checked", "checked");
						} else if (defaultShareMethod == "move") {
							$("#shareOptionDiv").find("input#chkMove").attr("checked", "checked");
						}
					}
					selectDeselectAllItems(false, false, basket);
				}

				// Share form submit action
				function performShareFormSubmit(destinationPath, fileName, quickShare, fileNames) {
                    $("#frmShareWindow").submit();
                    $(".mainProcessIndicator").show();
                    var obj = {};
                    var baseURL = document.location.href + "";
                    if (baseURL.indexOf("#") >= 0) baseURL = baseURL.substring(0, baseURL.indexOf("#"));
                    if(quickShare)
                    {
                        applyShareCustomizations();
                        if (!window.quickShareEmailBody) window.quickShareEmailBody = $("textarea#emailBody", "#shareOptionDiv").val();
                        if (o.buggyBrowser) {
                            window.quickShareEmailBody = window.quickShareEmailBody.replace(/([^>\r\n]?)(\r\n|\n\r|\r|\n)/g, '$1\r$2');
                        }
                        $("textarea#emailBody", "#shareOptionDiv").val(window.quickShareEmailBody.replace(/{files}/g, fileNames));
                        window.ShareItemExpiresInDays = window.ShareItemExpiresInDays || 30;
                        var myDate = new Date();
                        myDate.setDate(myDate.getDate() + window.ShareItemExpiresInDays);
                        var prettyDate = (myDate.getMonth() + 1) + '/' + myDate.getDate() + '/' + myDate.getFullYear();
                        obj = {
                            command: "publish",
                            allowUploads: "false",
                            attach: "false",
                            baseUrl: crushFTPTools.encodeURILocal(baseURL),
                            emailBcc: stripDownEmails($("input#emailBcc", "#shareOptionDiv").val()),
                            emailBody: crushFTPTools.encodeURILocal($("textarea#emailBody", "#shareOptionDiv").val()),
                            emailCc: stripDownEmails($("input#emailCc", "#shareOptionDiv").val()),
                            emailFrom: stripDownEmails($("input#emailFrom", "#shareOptionDiv").val()),
                            emailSubject: crushFTPTools.encodeURILocal($("input#emailSubject", "#shareOptionDiv").val()),
                            emailTo: stripDownEmails($("input#emailTo", "#shareOptionDiv").val()),
                            shareUsername: $("input#shareUsername", "#shareOptionDiv").is(":checked"),
                            shareUsernames: $("input#shareUsernames", "#shareOptionDiv").val(),
                            shareUsernamePermissions: "(read)",
                            expire: prettyDate + " 23:59" ,
                            paths: crushFTPTools.encodeURILocal(fileName),
                            publishType: "reference",
                            sendEmail: window.quickShareSendEmail || "false"
                        };
                        var shareThumbnail = $(document).data("shareThumbnail");
                        if (shareThumbnail) {
                            if (shareThumbnail == "true") {
                                obj.attach = "true";
                            }
                        }
                        var shareAllowUploads = $(document).data("shareAllowUploads");
                        if (shareAllowUploads) {
                            if (shareAllowUploads == "true") {
                                obj.allowUploads = "true";
                            }
                        }
                        var defaultShareMethod = $(document).data("defaultShareMethod");
                        if (defaultShareMethod) {
                            defaultShareMethod = defaultShareMethod.toLowerCase();
                            if (defaultShareMethod == "copy") {
                                obj.publishType = "copy";
                            } else if (defaultShareMethod == "reference") {
                                obj.publishType = "reference";
                            } else if (defaultShareMethod == "move") {
                                obj.publishType = "move";
                            }
                        }
                        if(typeof window.shareWindowFlagDirectLinkForFile != "undefined")
                        {
                            obj.direct_link = !window.shareWindowFlagDirectLinkForFile;
                        }
                    }
                    else
                    {
					   //Validate form first
    					if (!validateShareForm()) {
                            $(".mainProcessIndicator").hide();
    						return false;
    					}
    					$("table", "#shareOptionDiv").hide()
    					$("table", "#shareOptionDiv").after("<div class='wait' style='background-position: 0px -1px;margin:10px 0px;'>"+getLocalizationKey("loadingIndicatorText")+"</div>");
    					$("#shareOptionDiv").find(".closeButton").hide(500);
    					//Build share object and submit
    					var shareUsernamePermissionsStr = "(resume)(view)(slideshow)";
    					if ($("#shareUsernamePermissionsDownload", "#shareOptionDiv").is(":checked")) shareUsernamePermissionsStr += "(read)";
    					if ($("#shareUsernamePermissionsUpload", "#shareOptionDiv").is(":checked")) shareUsernamePermissionsStr += "(write)(rename)(makedir)";
    					if ($("#shareUsernamePermissionsDelete", "#shareOptionDiv").is(":checked")) shareUsernamePermissionsStr += "(delete)(deletedir)";
                        var shareBody = $("textarea#emailBody", "#shareOptionDiv").val();
                        if (o.buggyBrowser) {
                            shareBody = shareBody.replace(/([^>\r\n]?)(\r\n|\n\r|\r|\n)/g, '$1\r$2');
                        }
    					obj = {
    						command: "publish",
    						allowUploads: $("input#fullaccess", "#shareOptionDiv").is(":checked"),
    						attach: $("input#attach", "#shareOptionDiv").is(":checked"),
    						baseUrl: crushFTPTools.encodeURILocal(baseURL),
    						emailBcc: stripDownEmails($("input#emailBcc", "#shareOptionDiv").val()),
    						emailBody: crushFTPTools.encodeURILocal(shareBody),
    						emailCc: stripDownEmails($("input#emailCc", "#shareOptionDiv").val()),
    						emailFrom: stripDownEmails($("input#emailFrom", "#shareOptionDiv").val()),
    						emailSubject: crushFTPTools.encodeURILocal($("input#emailSubject", "#shareOptionDiv").val()),
    						emailTo: stripDownEmails($("input#emailTo", "#shareOptionDiv").val()),
    						shareUsername: $("input#shareUsername", "#shareOptionDiv").is(":checked"),
    						shareUsernames: $("input#shareUsernames", "#shareOptionDiv").val(),
    						shareUsernamePermissions: shareUsernamePermissionsStr,
    						expire: $("input#txtDate", "#shareOptionDiv").attr("date") + " " + $("input#txtTime", "#shareOptionDiv").val(),
    						paths: crushFTPTools.encodeURILocal(fileName),
    						publishType: $("input:checked", ".publishType").val(),
    						sendEmail: $("input#sendEmail", "#shareOptionDiv").is(":checked")
    					};
                        if(!obj.shareUsername)
                        {
                            var directLink = $("#frmShareWindow").find(".directLink");
                            if(window.directLinkonShare)
                            {
                                obj.direct_link = directLink.find("input").is(":checked");
                            }
                        }
                    }
					$.ajax({
						type: "POST",
						url: o.ajaxCallURL,
						data: obj,
						success: function (response) {
                            $(".mainProcessIndicator").hide();
							var responseText = response;
							var username = '',
								password = '',
								message = '',
								url = '';
							try {
								var msgs = responseText.getElementsByTagName("commandResult");
								for (var x = 0; x < msgs.length; x++) {
									username += IE(msgs[x].getElementsByTagName("username")[0]).textContent;
									password += IE(msgs[x].getElementsByTagName("password")[0]).textContent;
									message += unescape(IE(msgs[x].getElementsByTagName("message")[0]).textContent);
									url += unescape(IE(msgs[x].getElementsByTagName("url")[0]).textContent);
								}
							} catch (ex) {}
                            message = window.localizeServerMessage(message);
							$("div.wait", "#shareOptionDiv").remove();
							$("#shareOptionDiv").parent().find(".closeButton").show(500);
                            if(quickShare)
                            {
                                if (message.indexOf("ERROR:") == 0) {
                                    var msg = $("<div style='margin:10px 0px;line-height:25px;'>" + message + "<br/><br/>" + "</div>");
                                    msg.dialog({
                                        title : "Publish failed.",
                                        width : 500,
                                        buttons: { "Ok": function() { $(this).dialog("close"); } },
                                        show: { effect: 'drop', direction: "up" },
                                        dialogClass : "publishStatusDialog",
                                        open : function(){
                                            msg.parent().find(".ui-dialog-buttonpane").css("background-color", "inherit");
                                        }
                                    });
                                } else {
                                    var msg = $("<div style='margin:0px 0px;line-height:35px;'>"+message+"<br><strong>" + getLocalizationKey("ShareActionCompleteUsernameText") + "</strong>" + username + "<br/><strong>" + getLocalizationKey("ShareActionCompletePasswordText") + "</strong>" + password + "<br/> <strong>" + getLocalizationKey("ShareActionCompleteLinkText") + " :</strong> <a href=\"" + url + "\">" + url + "</a><br/>" + "</div>");
                                    if(window.shareWindowNoUserInfoAfterShare)
                                    {
                                        msg = $("<div style='margin:0px 0px;line-height:35px;'>"+message+"<br/> <strong>" + getLocalizationKey("ShareActionCompleteLinkText") + " :</strong> <a href=\"" + url + "\">" + url + "</a><br/>" + "</div>");
                                    }
                                    if(window.shareWindowNoOpenInEmail)
                                    {
                                        msg.find("a:first").hide();
                                    }
                                    msg.dialog({
                                        title : "Publish complete.",
                                        width : 500,
                                        buttons: { "Ok": function() { $(this).dialog("close"); } },
                                        show: { effect: 'drop', direction: "up" },
                                        dialogClass : "publishStatusDialog",
                                        open : function(){
                                            msg.find("a").blur();
                                            msg.parent().find(".ui-dialog-buttonpane").css("background-color", "inherit");
                                        },
                                        resizable: false
                                    });
                                }
                            }
                            else
                            {
    							if (message.indexOf("ERROR:") == 0) {
    								$("table", "#shareOptionDiv").after("<div style='margin:10px 0px;line-height:25px;'>" + message + "<br/><br/><input style='float:right;margin-bottom:10px;padding:2px 20px;' type=\"submit\" value=\"OK\" onclick=\"$.unblockUI(); return false;\" />" + "</div>");
    							} else {
    								if ($("input#shareUsername", "#shareOptionDiv").is(":checked"))
    								{
    									$("table", "#shareOptionDiv").after("<div style='margin:10px 0px;line-height:25px;'>" + message + "<br/>" + getLocalizationKey("ShareActionCompleteShareUsernamesText") + "<br/>" + $("input#shareUsernames", "#shareOptionDiv").val() + "<br/><input style='float:right;margin-bottom:10px;padding:2px 20px;' type=\"submit\" value=\"" + getLocalizationKey("ShareActionCompleteOkButtonText") + "\" onclick=\"$.unblockUI(); return false;\" />" + "</div>");

                                        if(window.shareWindowNoOpenInEmail)
                                        {
                                            $("table", "#shareOptionDiv").next().find("a:first").hide();
                                        }
    								}
    								else
                                    {
                                        if(window.shareWindowNoUserInfoAfterShare)
                                        {
                                            $("table", "#shareOptionDiv").after("<div style='margin:10px 0px;line-height:25px;'>" + message + "<br/> " + getLocalizationKey("ShareActionCompleteLinkText") + " <a href='" + url + "'>" + url + "</a><br/><br/><input style='float:right;margin-bottom:10px;padding:2px 20px;' type=\"submit\" value=\"" + getLocalizationKey("ShareActionCompleteOkButtonText") + "\" onclick=\"$.unblockUI(); return false;\" />" + "</div>");
                                        }
                                        else
                                        {
                                            $("table", "#shareOptionDiv").after("<div style='margin:10px 0px;line-height:25px;'>" + message + "<br/>" + getLocalizationKey("ShareActionCompleteUsernameText") + username + "<br/>" + getLocalizationKey("ShareActionCompletePasswordText") + password + "<br/> " + getLocalizationKey("ShareActionCompleteLinkText") + " <a href='" + url + "'>" + url + "</a><br/><br/><input style='float:right;margin-bottom:10px;padding:2px 20px;' type=\"submit\" value=\"" + getLocalizationKey("ShareActionCompleteOkButtonText") + "\" onclick=\"$.unblockUI(); return false;\" />" + "</div>");
                                        }
                                        if(window.shareWindowNoOpenInEmail)
                                        {
                                            $("table", "#shareOptionDiv").next().find("a:first").hide();
                                        }
                                    }
    							}
                            }
						},
						error: function () {
                            $(".mainProcessIndicator").hide();
							$.growlUI(getLocalizationKey("ProblemWhileSharingGrowlText"), getLocalizationKey("ProblemWhileSharingDescGrowlText"), o.GrowlTimeout, "growlError", o.GrowlWithCloseButton);
						}
					});
				}

				//Copy item path/link action
				function copypath(context) {
					var el = false;
					if (context) {
						el = currentContext();
					}
					//If context allow, show link in a popup
					if (el) {
						var $curElem = $(el);
						var fileName = $curElem.find("a:first").attr("rel");
						var destinationPath = location.href;
						if (destinationPath.indexOf("#") >= 0) destinationPath = destinationPath.substring(0,destinationPath.indexOf("#"));
						if ($curElem.hasClass("fileTR") || $curElem.hasClass("fileThumb")) {
							destinationPath = (destinationPath + fileName.substring(1));
						} else {
							destinationPath = (destinationPath + fileName.substring(1));
						}
						performAction("copyDirectLinkDiv");
						$("#txtDirectLink").val(destinationPath)[0].select();
						$("#txtDirectLink")[0].focus();
					} else {
						$.growlUI(getLocalizationKey("NothingSelectedGrowlText"), getLocalizationKey("DirectLinkDescGrowlText"), o.GrowlTimeout, "growlError");
					}
				}

				//Update keyword action
				function updateKeywords(context) {
					//Update keyword alert
					function updateKeywordAlert(msg, color, timeout) {
						$popup.find(".errorNote").remove();
						timeout = timeout || 2000;
						var curElem = $("textarea", $("#keywordsDiv"));
						curElem.after("<span class='errorNote' style='cursor:pointer;float:left;margin-left: 7px;font-size: 11px;line-height: 25px;color:" + color + ";'>" + msg + "</span>");
						curElem.next().click(function () {
							$(this).fadeOut(1000, function () {
								$(this).remove()
							});
						});
					}
					var _fileName = "";
					var elem = false;
					var basket = false;
					if (context) {
						elem = currentContext();
						if (elem) {
							var $curElem = $(elem);
							_fileName = $curElem.find("a:first").attr("rel");
							basket = $curElem.hasClass("contextMenuItem");
						}
					}
					var checkedFiles = {};
					if(basket)
					{
						if (currentView(basket) == "Thumbnail") {
							checkedFiles = $("#FileBasketList").find("li.fileBoxSelected:visible");
						} else {
							checkedFiles = $("#FileBasketList").find("input.chkBox:visible:checked");
						}
					}
					else
					{
						if (currentView() == "Thumbnail") {
							checkedFiles = $("#filesContainerDiv").find("li.fileBoxSelected:visible");
						} else {
							checkedFiles = $("#filesListing").find("input.chkBox:visible:checked");
						}
					}
					if (checkedFiles.length == 0 && !elem) {
						$.growlUI(getLocalizationKey("NothingSelectedGrowlText"), getLocalizationKey("UpdateKeywordDescGrowlText"), o.GrowlTimeout, "growlError");
						return;
					}
					var stringToCopy = _fileName;
					var totalFiles = elem.length;
					checkedFiles.each(function () {
						var parentElem = $(this);
						if (currentView(basket) != "Thumbnail") {
							parentElem = $(this).closest("tr");
						}
						var filePath = unescape(parentElem.find("a").attr("rel"));
						filePath = unescape(filePath.replace("//", "/"));
						if (_fileName != filePath) {
							if (stringToCopy.length > 0) {
								stringToCopy += "\r\n";
							}
							stringToCopy += (filePath);
							totalFiles += 1;
						}
					});
					var $curElem = checkedFiles;
					if (context) {
						$curElem = elem;
					}
					$("#KeywordsWindowHeaderText").find("span").remove();
					$("#KeywordsWindowHeaderText").append("<span> : Updating total : " + totalFiles + " item(s)</span>");
					var keywords = unescape(crushFTPTools.decodeXML($($curElem[0]).attr("keywords")));
					performAction("keywordsDiv");
					if($("div#filesBasket").dialog("isOpen"))
						$(".blockMsg").css("z-index", 1002);
					var $popup = $("#keywordsDiv");
					$("#txtKeywords", $popup).val(keywords)[0].focus();
					$popup.find(".errorNote").remove();
					$("a.update", $popup).unbind().click(function () {
						$(this).blur();
						var newKeywords = $("#txtKeywords", $popup).val();
						var obj = {
							command: "editKeywords",
							keywords: crushFTPTools.encodeURILocal(unescape(newKeywords)),
							names: crushFTPTools.encodeURILocal(unescape(stringToCopy)),
							random: Math.random()
						};
						$popup.find(".buttonPanel").addClass("wait");
						$popup.find(".errorNote").remove();
						$.ajax({
							type: "POST",
							url: o.ajaxCallURL,
							data: obj,
							success: function (response) {
								var responseText = getActionResponseText(response);
								$popup.find(".buttonPanel").removeClass("wait");
								responseText = $.trim(responseText);
								if (responseText.indexOf("Keywords Edited.") >= 0) {
									$.unblockUI();
									if (currentView(basket) != "Thumbnail") {
										checkedFiles.each(function () {
											$(this).attr("keywords", newKeywords);
											$(this).attr("keywords", newKeywords);
											var $curElem = $(this).closest("TR");
											$curElem.find(".columnKeywords").attr("title", newKeywords);
											if (newKeywords.length >= o.MaximumLengthAllowedForKeywordsString) {
												newKeywords = newKeywords.substr(
												0, o.MaximumLengthAllowedForKeywordsString) + "...";
											}
											$curElem.find(".columnKeywords").html(crushFTPTools.xmlEncode(newKeywords));
											$($curElem).animate({
												"background-color": "#FFFFCC"
											}, 500, function () {
												$($curElem).animate({
													"background-color": "#FFFFFF"
												}, 500);
											});
										});
										if (context) {
											$(elem).attr("keywords", newKeywords);
											$(elem).attr("keywords", newKeywords);
											var $curElem = $(elem).closest("TR");
											$curElem.find(".columnKeywords").attr("title", newKeywords);
											if (newKeywords.length >= o.MaximumLengthAllowedForKeywordsString) {
												newKeywords = newKeywords.substr(
												0, o.MaximumLengthAllowedForKeywordsString) + "...";
											}
											$curElem.find(".columnKeywords").html(crushFTPTools.xmlEncode(newKeywords));
											$($curElem).animate({
												"background-color": "#FFFFCC"
											}, 500, function () {
												$($curElem).animate({
													"background-color": "#FFFFFF"
												}, 500);
											});
										}
									}
								} else {
									updateKeywordAlert("(Error : " + responseText + ")", "red");
								}
							},
							error: function (XMLHttpRequest, textStatus, errorThrown) {
								updateKeywordAlert("(Error : " + errorThrown + ")", "red");
								$popup.find(".buttonPanel").removeClass("wait");
							}
						});
					});
					$("a.cancel", $popup).unbind().click(function () {
						$.unblockUI();
					});
				}

				//Build a form and submit form to server in hidden way using iFrame
				window.submitAction = function(opt, requestType) {
					var uniqueIFrameID = "i" + Math.random();
					var uniqueIFrame = $("<iframe id=\"" + uniqueIFrameID + "\" name=\"" + uniqueIFrameID + "\" src=\"javascript:false;\" style=\"display:none;\"></iframe>");
					$("body").append(uniqueIFrame);
					$("#crushftp_action").remove();
					$("body").append('<form id="crushftp_action" style=\"display:none;\" name="crushftp_action" enctype="multipart/form-data" method="post">' + '<input type="text" id="command" name="command" value="" />' + '<input type="text" id="path" name="path" value="" />' + '<input type="text" id="paths" name="paths" value="" />' + '<input type="text" id="random" name="random" value="" />' + '</form>');
					var formToSubmit = $("#crushftp_action");
					if(requestType)
					{
						formToSubmit.attr("method", requestType);
					}
					formToSubmit.attr("action", o.downloadURL).attr("target", uniqueIFrameID);
					formToSubmit.find("input").val("");
					for (var key in opt) {
						if (opt.hasOwnProperty(key)) {
							if(formToSubmit.find(key).attr("value", opt[key]).length==0)
							{
								formToSubmit.append('<input type="text" id="'+key.replace("#", "")+'" name="'+key.replace("#", "")+'" value="'+opt[key]+'" />');
							}
						}
					}
					formToSubmit.submit();
				}

				//Download low res
				function downloadLowRes(context, el)
				{
                    var _fileName = "";
                    var elem = false;
                    var basket = false;
                    if (context) {
                        elem = currentContext();
                        if (elem) {
                            var $curElem = $(elem);
                            _fileName = $curElem.find("a:first").attr("rel");
                            basket = $curElem.hasClass("contextMenuItem");
                        }
                    }
                    var checkedFiles = {};
                    if(basket)
                    {
                        if (currentView(basket) == "Thumbnail") {
                            checkedFiles = $("#FileBasketList").find("li.fileBoxSelected:visible");
                        } else {
                            checkedFiles = $("#FileBasketList").find("input.chkBox:visible:checked");
                        }
                    }
                    else
                    {
                        if (currentView() == "Thumbnail") {
                            checkedFiles = $("#filesContainerDiv").find("li.fileBoxSelected:visible");
                        } else {
                            checkedFiles = $("#filesListing").find("input.chkBox:visible:checked");
                        }
                    }
                    if (checkedFiles.length == 0 && !elem) {
                        $.growlUI(getLocalizationKey("NothingSelectedGrowlText"), getLocalizationKey("UpdateKeywordDescGrowlText"), o.GrowlTimeout, "growlError");
                        return;
                    }
                    var filesToDownload = _fileName;
                    var totalFiles = elem.length;
                    checkedFiles.each(function () {
                        var parentElem = $(this);
                        if (currentView(basket) != "Thumbnail") {
                            parentElem = $(this).closest("tr");
                        }
                        var filePath = unescape(parentElem.find("a").attr("rel"));
                        filePath = unescape(filePath.replace("//", "/"));
                        if (_fileName != filePath) {
                            if (filesToDownload.length > 0) {
                                filesToDownload += ";";
                            }
                            filesToDownload += (filePath);
                            totalFiles += 1;
                        }
                    });
					if(filesToDownload)
					{
						var pathToDownload = unescape(filesToDownload);
						submitAction({
							'#command': "getPreview",
							'#random': Math.random(),
							"#size" : "3",
							'#path': pathToDownload,
							"#download" : "true"
						}, "POST");
					}
                    else
                    {
                        $.growlUI(getLocalizationKey("DownloadNothingSelectedGrowlText"), "&nbsp;", o.GrowlTimeout, "growlError");
                        return;
                    }
					return false;
				}

				//Download items
				window.downloadItems = function (context, el, fileToDownload) {
					el = el || false;
					var basket = false;
					if ($(document).data("slideShowOnly")) { // For slideshow only version
						var fileName = crushFTPTools.encodeURILocal(unescape(el));
						submitAction({
							'#command': "download",
							'#random': Math.random(),
							'#path': fileName
						});
					} else {
						if (context) {
							el = currentContext();
							if (el) {
								basket = $(el).hasClass("contextMenuItem");
							}
						}
						if(el)
						{
							var privs = "";
							if(currentView(basket) == "Thumbnail"){
								if(el.data("dataRow")){
									privs = el.data("dataRow").privs.toString();
								}
								else if(el.attr("privs"))
								{
									privs = unescape(el.attr("privs"));
								}
							}
							else {
								privs = unescape(el.attr("privs"));
								if(basket)
								{
									privs = el.closest("tr").data("dataRow").privs.toString();
								}
							}
							if(privs.indexOf("(read)")<0)
								return false;
						}
						var count = 0;
						var stringToCopy = "";
						var selectedFiles = [];
						var totalSizeToDownload = 0;
						if (el) {
							var $curElem = $(el);
							stringToCopy = $curElem.find("a:first").attr("rel");
							selectedFiles.push(stringToCopy);
							count++;
							if (currentView(basket) != "Thumbnail") {
								totalSizeToDownload += parseFloat(el.closest("tr").find("td.columnName").attr("sizeinbytes"));
							}
							else
							{
								totalSizeToDownload += parseFloat(el.attr("sizeinbytes"));
							}
						}
						var checkedFiles = {};
						if (currentView(basket) == "Thumbnail") {
							if(basket)
							{
								checkedFiles = $("#FileBasketList").find("li.fileBoxSelected:visible");
							}
							else
							{
								checkedFiles = $("#filesContainerDiv").find("li.fileBoxSelected:visible");
							}
						} else {
							if(basket)
							{
								checkedFiles = $("#FileBasketList").find("input.chkBox:visible:checked");
							}
							else
							{
								checkedFiles = $("#filesListing").find("input.chkBox:visible:checked");
							}
						}
						checkedFiles.each(function () {
							var parentElem = $(this);
							if (currentView(basket) != "Thumbnail") {
								parentElem = $(this).closest("tr");
								if(el && el.length>0 && el.closest("tr").length>0)
								{
									if(el.closest("tr")[0] != parentElem[0])
									{
										totalSizeToDownload += parseFloat(parentElem.find("td.columnName").attr("sizeinbytes"));
									}
								}
								else
								{
									totalSizeToDownload += parseFloat(parentElem.find("td.columnName").attr("sizeinbytes"));
								}
							}
							else
							{
								if(el && el.length>0)
								{
									if(el[0] != parentElem[0])
									{
										totalSizeToDownload += parseFloat($(this).attr("sizeinbytes"));
									}
								}
								else
								{
									totalSizeToDownload += parseFloat($(this).attr("sizeinbytes"));
								}
							}
							var filePath = unescape(parentElem.find("a:first").attr("rel"));
							filePath = filePath.toString();
							filePath = filePath.replace("//", "/");
							filePath = filePath.toString();
							if(!selectedFiles.has(filePath))
							{
								if(stringToCopy.length>0)
									stringToCopy += ":" + filePath;
								else
									stringToCopy = filePath;
								count++;
							}
						});
						var maxAllowedDownloadSize = parseFloat($(document).data("maxAllowedDownloadSize"));
						if(maxAllowedDownloadSize>0 && totalSizeToDownload>maxAllowedDownloadSize)
						{
							$.growlUI(getLocalizationKey("maxAllowedDownloadSizeReached"), getLocalizationKey("maxAllowedDownloadSizeReachedText").replace("{size}",formatBytes(maxAllowedDownloadSize)), o.GrowlTimeout, "growlError", o.GrowlWithCloseButton);
							return false;
						}

						if(fileToDownload)
						{
							stringToCopy = fileToDownload;
							count++;
						}
						if (count > 0) {
							if (count > 1) //multiple selected, do zip
							{
								downloadAsZip(el, false, basket);
								return;
							} else {
								if (currentView(basket) == "Thumbnail") {
									if (!el) {
										el = $(checkedFiles[0]);
									}
									if (el.hasClass("directoryThumb")) {
										downloadAsZip(el, true, basket);
										return;
									}
								} else {
									if (!el) {
										el = $(checkedFiles[0]);
										if (el) {
											el = el.closest("td").next();
										}
									}
									if (el.hasClass("directory")) {
										downloadAsZip(el, true, basket);
										return;
									}
								}
							}
							submitAction({
								'#command': "download",
								'#random': Math.random(),
								'#path': crushFTPTools.encodeURILocal(unescape(stringToCopy))
							});
						} else {
							$.growlUI(getLocalizationKey("DownloadNothingSelectedGrowlText"), "&nbsp;", o.GrowlTimeout, "growlError");
							return;
						}
					}
					$.growlUI(getLocalizationKey("DownloadStartedAlertTitleText"), getLocalizationKey("DownloadStartedAlertDescText"), o.GrowlTimeout);
				}

				//Rename action
				function performRenameAction(context) {
					var el = false;
					var basket = false;
					if (context) {
						el = currentContext();
						if (el) {
							basket = $(el).hasClass("contextMenuItem");
						}
					}
					if (currentView(basket) != "Thumbnail") { //Treeview
						if (!el) {
							var checkedFiles = $("#filesListing").find("input.chkBox:visible:checked");
							if (checkedFiles && checkedFiles.length > 0) {
								el = $(checkedFiles[0]).closest("tr").find(".columnName");
							}
						}
						if (!el || el.length == 0) {
							$.growlUI(getLocalizationKey("RenameNothingSelectedGrowlText"), "&nbsp;", o.GrowlTimeout, "growlError");
							return;
						}
						var $curElem = $(el);
						var renameTemplate = "<div class='renamePanel'><input type='text' class='renameField' /><div class='saveButton'>" + getLocalizationKey("RenamePanelSaveLinkText") + "</div><div class='cancelButton'>" + getLocalizationKey("RenamePanelCancelLinkText") + "</div></div>";
						//Disable context menu on current item while rename is still not completed
						$curElem.disableContextMenu();
						$curElem.find("span,a").hide();
						$curElem.append(renameTemplate);
						$curElem.find(".renameField").val($curElem.find("a").text())[0].select();
						$curElem.find(".renameField")[0].focus();
						$curElem.removeAttr("title");
						$curElem.find(".cancelButton").click(function () {
							$curElem.find("div.renamePanel").remove();
							$curElem.find("span,a").show();
							$curElem.enableContextMenu(); // Re-enable context menu
							bindContextMenu($curElem);
						});
						//Enter key press event
						$curElem.find(".renameField").keyup(function (evt) {
							var evt = (evt) ? evt : ((event) ? event : null);
							if (evt.keyCode == 13) {
								$curElem.find(".saveButton").click();
								return false;
							} else if (evt.keyCode == 27) {
								$curElem.find(".cancelButton").click();
								return false;
							}
						});
						$curElem.find(".saveButton").click(function () {
							var newName = $curElem.find(".renameField").val();
							newName = newName.replace(/\//g, o.folderNameSpecialCharacterSubstitute).replace(/:/g, o.folderNameSpecialCharacterSubstitute);
							$curElem.find(".renameField").val(newName);
							var oldName = $curElem.find("a").text();
							var pathName = $(el).parent().attr("rel");
							var obj = {
								command: "rename",
								path: crushFTPTools.encodeURILocal(unescape(pathName)),
								name1: crushFTPTools.encodeURILocal(unescape(oldName)),
								name2: crushFTPTools.encodeURILocal(unescape(newName)),
								random: Math.random()
							};
							$curElem.addClass("wait");
							$.ajax({
								type: "POST",
								url: o.ajaxCallURL,
								data: obj,
								success: function (response) {
									var responseText = getActionResponseText(response);
									var loadPreview = false;
									if (responseText.length > 0) {
										$.growlUI(getLocalizationKey("ProblemWhileRenamingGrowlText"), getLocalizationKey("ProblemWhileRenamingDescGrowlText") + responseText, o.GrowlTimeout, "growlError", o.GrowlWithCloseButton);
									} else {
										if(basket)
										{
											var fileFullName = obj.path + obj.name1;
											//Items in the basket
											var ItemsInTheBasket = $(document).data(o.BasketDataKey);
											for(var i=0;i<ItemsInTheBasket.length;i++)
											{
												if(unescape(fileFullName) == unescape(ItemsInTheBasket[i].file))
												{
													ItemsInTheBasket[i].name = obj.name2;
													ItemsInTheBasket[i].file = obj.path + obj.name2;
												}
											}
										}
										if ($curElem.hasClass("directory")) {
											var link = $curElem.find("a");
											var nameToChange = link.attr("rel");
											link.text(newName).attr("href", $curElem.closest("tr").attr("rel") + newName + "/").attr("rel", $curElem.closest("tr").attr("rel") + newName + "/").prev().attr("rel", $curElem.closest("tr").attr("rel") + newName + "/");
											$curElem.find("span.expandButton").attr("rel", $curElem.closest("tr").attr("rel") + newName + "/");
											$curElem.find("div.renamePanel").remove();
											$curElem.find("span,a").show();
											$curElem.attr("name", newName);
											var filesContainer = $("table#filesContainer");
											//Method to update links of item after rename

											function updateLinks(old, update) {
												old = escape(old);
												update = escape(update);
												filesContainer.find("tr[rel='" + old + "']").each(function () {
													var curItem = $(this);
													if (curItem.find("td.directory").length > 0) {
														updateLinks(old + curItem.find("td.directory").attr("name") + "/", update + curItem.find("td.directory").attr("name") + "/");
													}
													curItem.attr("rel", update).attr("rootdir", update);
													curItem.find("a").attr("rel", update + curItem.find("a").closest("td").attr("name")).attr("href", unescape(update + curItem.find("a").closest("td").attr("name"))).attr("title", "<img src=\"" + o.ajaxCallURL + "?command=getPreview&size=3&path=" + crushFTPTools.encodeURILocal(unescape(update + curItem.find("a").closest("td").attr("name"))) + "&random="+Math.random()+"&frame=1" + "\"" + " border='0' />");
												});
											}
											updateLinks(nameToChange, $curElem.closest("tr").attr("rel") + newName + "/");
											var expandedFolder = newName;
											var expandedFolders = $(document).data("expandedFolders");
											if (!expandedFolders) {
												expandedFolders = [];
											}
											if ($curElem.hasClass("expanded")) {
												if (!expandedFolders.has(expandedFolder)) {
													expandedFolders.push(expandedFolder);
												}
											} else {
												if (expandedFolders.has(expandedFolder)) {
													expandedFolders.remove(expandedFolders.indexOf(expandedFolder));
												}
											}
											$(document).data("expandedFolders", expandedFolders);
											//Update names and reference in document cache

											function updateNames(dirItems, _path, _old, _new, sub) {
												if (sub) {
													for (var item in dirItems) {
														if (dirItems[item].root_dir == _path) {
															dirItems[item].root_dir = unescape(_new);
															dirItems[item].href_path = dirItems[item].root_dir + dirItems[item].name;
															if (dirItems[item].type == "DIR") {
																updateNames(dirItems, unescape(_old) + dirItems[item].name + "/", unescape(_old) + dirItems[item].name + "/", unescape(_new) + dirItems[item].name + "/", true);
															}
														}
													}
												} else {
													for (var item in dirItems) {
														if (dirItems[item].name == unescape(_old)) {
															dirItems[item].name = unescape(_new);
															dirItems[item].href_path = dirItems[item].href = dirItems[item].root_dir + unescape(_new);
														}
														if (dirItems[item].root_dir == _path + unescape(_old) + "/") {
															dirItems[item].root_dir = _path + unescape(_new) + "/";
															dirItems[item].href_path = dirItems[item].root_dir + dirItems[item].name;
															if (dirItems[item].type == "DIR") {
																updateNames(dirItems, _path + unescape(_old) + "/" + dirItems[item].name + "/", _path + unescape(_old) + "/" + dirItems[item].name + "/", _path + unescape(_new) + "/" + dirItems[item].name + "/", true);
															}
														}
													}
												}
											}
											if (l && l.length > 0) {
												updateNames(l, pathName, oldName, newName);
											}
											if (window.curTreeItems && window.curTreeItems.length > 0) {
												updateNames(window.curTreeItems, pathName, oldName, newName);
											}
										} else if ($curElem.hasClass("fileItem") || $curElem.hasClass("fileTR")) {
											var FileExtension = getFileExtension($curElem.find("a").text());
											var link = $curElem.find("a").text(newName);
											link.attr("href", $curElem.closest("tr").attr("rel") + newName);
											link.attr("rel", link.attr("href"));
											FileExtension = getFileExtension(newName);
											$curElem.removeAttr("title");
											$curElem.find("div.renamePanel").remove();
											$curElem.find("span,a").show();
											$curElem.attr("name", newName);
											if (!$curElem.closest("tr").data("menuOn")) {
												$curElem.closest("tr").removeClass("rowHoverFixed").removeClass("rowHover");
											}
											loadPreview = true;
										}
										$curElem.enableContextMenu();
										$($curElem).closest("TR").animate({
											"background-color": "#FFFFCC"
										}, 500, function () {
											$($curElem).closest("TR").animate({
												"background-color": "#FFFFFF"
											}, 500, function () {
												if (loadPreview) {
													loadIconPreview(
													1, true, $($curElem), basket);
												}
												bindContextMenu($curElem);
											});
										});
									}
								},
								complete: function () {
									$curElem.removeClass("wait");
								},
								error: function () {
									$.growlUI(getLocalizationKey("ProblemWhileRenamingGrowlText"), getLocalizationKey("ProblemWhileRenamingDescGrowlText"), o.GrowlTimeout, "growlError", o.GrowlWithCloseButton);
								}
							});
						});
					} else { // Thumbs view
						if (!el) {
							el = $("#filesContainerDiv").find("li.fileBoxSelected:visible:first");
						}
						if (!el || el.length == 0) {
							$.growlUI(getLocalizationKey("RenameNothingSelectedGrowlText"), "&nbsp;", o.GrowlTimeout, "growlError");
							return;
						}
						if ($("#thumbRenamePanel").length == 0) {
							var renameTemplate = "<div class='renamePanel'><h2>" + getLocalizationKey("RenameWindowHeaderText") + "</h2><input type='text' class='renameField' /><div class='saveButton'>" + getLocalizationKey("RenamePanelSaveLinkText") + "</div>&nbsp;&nbsp;<div class='cancelButton'>" + getLocalizationKey("RenamePanelCancelLinkText") + "</div></div>";
							$("body").append("<div id='thumbRenamePanel'>" + renameTemplate + "</div>");
							$("#thumbRenamePanel").hide();
						}
						var $renameBox = $('#thumbRenamePanel');
						//var toTop = (window.screen.availHeight / 2) - ($renameBox.height() * 2);
						$.blockUI({
							message: $renameBox,
							css: {
								padding: '10px 10px 20px 30px',
								'background-color': getPopupColor(true),
								'border': "1px solid " + getPopupColor(),
								'-webkit-border-radius': '10px',
								'-moz-border-radius': '10px',
								color: '#000',
								opacity: 0.9,
								top: '20%',
								left: '40%',
								width: '305px'
							}
						});
						if(basket)
						{
							$(".blockOverlay").css("z-index", "1002");
							$(".blockMsg").css("z-index", "1003");
						}
						$renameBox.find(".renameField").val($(el).find("div.imgTitle").find("a").text()).focus();
						$renameBox.find(".cancelButton").unbind().click(
						function () {
							$.unblockUI();
							$("#thumbRenamePanel").remove();
							$renameBox.find("input").removeClass("wait");
						});
						$renameBox.find(".renameField").unbind().keyup(

						function (evt) {
							var evt = (evt) ? evt : ((event) ? event : null);
							if (evt.keyCode == 13) {
								$renameBox.find(".saveButton").click();
								return false;
							} else if (evt.keyCode == 27) {
								$renameBox.find(".cancelButton").click();
								return false;
							}
						});
						$renameBox.find(".saveButton").unbind().click(
						function () {
							var newName = $renameBox.find(".renameField").val();
							newName = newName.replace(/\//g, o.folderNameSpecialCharacterSubstitute).replace(/:/g, o.folderNameSpecialCharacterSubstitute);
							$renameBox.find(".renameField").val(newName);

							var oldName = $(el).find("div.imgTitle").find("a").text();
							var pathName = $(el).find("div.imgTitle").find("a").attr("rel");
							var obj = {
								command: "rename",
								path: crushFTPTools.encodeURILocal(unescape(pathName)),
								name1: crushFTPTools.encodeURILocal(unescape(oldName)),
								name2: crushFTPTools.encodeURILocal(unescape(newName)),
								random: Math.random()
							};
							$renameBox.find("input").addClass("wait");
							$.ajax({
								type: "POST",
								url: o.ajaxCallURL,
								data: obj,
								success: function (response) {
									var responseText = getActionResponseText(response);
									if (responseText.length > 0) {
										$.growlUI(getLocalizationKey("ProblemWhileRenamingGrowlText"), getLocalizationKey("ProblemWhileRenamingDescGrowlText") + responseText, o.GrowlTimeout, "growlError", o.GrowlWithCloseButton);
									} else {
										if(basket)
										{
											var fileFullName = obj.path + obj.name1;
											//Items in the basket
											var ItemsInTheBasket = $(document).data(o.BasketDataKey);
											for(var i=0;i<ItemsInTheBasket.length;i++)
											{
												if(unescape(fileFullName) == unescape(ItemsInTheBasket[i].file))
												{
													ItemsInTheBasket[i].name = obj.name2;
													ItemsInTheBasket[i].file = obj.path + obj.name2;
												}
											}
										}
										var link = $(el).find("div.imgTitle").find("a");
										if ($(el).hasClass("directoryThumb")) {
											link.text(newName).attr("href", link.attr("rel") + newName + "/");
										} else {
											link.text(newName).attr("href", link.attr("rel") + newName);
										}
										setTitleText(link);
										var imglink = $(el).find("a.imgLink");
										if ($(el).hasClass("directoryThumb")) {
											imglink.attr("rel", link.attr("rel") + newName + "/");
										} else {
											imglink.attr("rel", link.attr("rel") + newName);
										}
										imglink.attr("href", link.attr("href"));
										$renameBox.find(".cancelButton").click();
										$(el).removeAttr("title");
										$(el).find(".vtip").removeAttr("title");
										$($(el)).animate({
											"background-color": "#FFFFCC"
										}, 500, function () {
											$($(el)).animate({
												"background-color": "#FFFFFF"
											}, 500, function () {
												loadIconPreview(1, true, $(el), basket);
												bindContextMenu($(el));
											});
										});
									}
								},
								complete: function () {
									$renameBox.find("input").removeClass("wait");
								},
								error: function () {
									$.growlUI(getLocalizationKey("ProblemWhileRenamingGrowlText"), getLocalizationKey("ProblemWhileRenamingDescGrowlText"), o.GrowlTimeout, "growlError", o.GrowlWithCloseButton);
								}
							});
						});
					}
				}

				//Get action response text from server reply
				function getActionResponseText(msg) {
					var responseText = '';
					try {
						var msgs = msg.getElementsByTagName("commandResult");
						for (var x = 0; x < msgs.length; x++) {
							responseText += IE(msgs[x].getElementsByTagName("response")[0]).textContent;
						}
					} catch (ex) {}
					return responseText;
				}

				//Get data of elements from privs of elements
				function getDataOfElemFromPrivs(currentPrivs, val) {
					var comment = false;
					if (currentPrivs && val && val.length > 0) {
						val = "(" + val;
						var commentIndex = currentPrivs.indexOf(val);
						if (commentIndex >= 0) {
							comment = currentPrivs.substring(commentIndex, currentPrivs.length);
							comment = comment.substring(val.length, comment.indexOf(")"));
						}
					}
					return comment;
				}

				//Render main navigation buttons and context menu items
				function renderButtons() {
					if ($(document).data("uploadOnly")) { //No buttons for upload only
						return;
					}
                    else if(window.listingPageShown)
                    {
                        $("#mainNavigation").hide();
                        return;
                    }
					$("div.mainNavigation").find("a[href!='javascript:doLogout();']").parent().remove();
					var currentPrivs = $(document).data("folderPrivs");
                    currentPrivs = currentPrivs || "";
                    if($("#searchResultNotification").is(":visible"))
                        currentPrivs += "(read)";
					var comment = getDataOfElemFromPrivs(currentPrivs, "comment");
					if (comment &&  currentPrivs.indexOf("(inherited)")<0) {
						comment = unescape(comment);
                        comment = comment.replace(/\#LPR#/g, "(").replace(/\#RPR#/g, ")");
                        $("#comments").empty().html(comment).show();
					} else {
						$("#comments").hide();
					}
                    if(currentPrivs)
                        currentPrivs = currentPrivs.toLowerCase();
					var menuList = $(document).data("menuList");
					var mainNav = $("#mainNavigation").hide();
					if (menuList) {
						var mainMenu = $(".mainNavigation").find("ul.topnav");
						mainMenu.empty();
						//Loop through menu item and make a button list
						for (var i = 0; i < menuList.length; i++) {
							var text = menuList[i].name.toString();
							text = text.substring(text.indexOf(":") + 1, text.length);
							if (!currentPrivs || !menuList[i].requiredPriv || currentPrivs.indexOf(menuList[i].requiredPriv) >= 0 || menuList[i].name.toString().indexOf("(custom):")==0)
                            {
                                var link = menuList[i].text.replace(/\"/g,'\'');
                                if(link.endsWith(":external"))
                                {
                                    link = link.replace(":external", "");
                                    mainMenu.append("<li><a target=\"_blank\" class='menuLink' href=\"" + link + "\">" + text + "</a></li>");
                                }
                                else
                                    mainMenu.append("<li><a class='menuLink' href=\"" + link + "\">" + text + "</a></li>");
                            }
						}
						mainNav.hide();
					}
					//Highlight pase button if there are files copied
					highlightPasteButton();
					if (window.slideshowOnly) {
						$("div.mainNavigation").find("a[href!='javascript:doLogout();']").parent().remove();
					}
					//Build context menu
					var menuListContextMenu = $(document).data("menuListContextMenu");
					if (menuListContextMenu) {
						var mainMenu = $("#myMenu");
						mainMenu.empty();
						for (var i = 0; i < menuListContextMenu.length; i++) {
							var text = menuListContextMenu[i].name.toString();
							var val = text.substring(1, text.indexOf(":") - 1);
							text = text.substring(text.indexOf(":") + 1, text.length);
							var command = menuListContextMenu[i].text;
							if (command.indexOf("()") >= 0) {
								command = command.replace(")", "true)");
							} else {
								command = command.replace(")", ",true)");
							}
							command = command.replace(/\"/g,'\'');
							command = crushFTPTools.encodeURILocal(command);
							//command will be added to button's attribute, command will be evaluated on button click
							mainMenu.append('<li class="' + val.toLowerCase().replace(/ /g, "") + '"><a href="javascript:void(0);" command="' + unescape(command) + '">' + text + '</a></li>');
						}
					}
					if ($(document).data("username") == "anonymous") {
						//No logout link for anonymous
						$("ul.topnav,#myMenu").find("a:contains('Logout')").parent().remove();
					} else {
						$("ul.topnav,#myMenu").find("a:contains('Login')").parent().remove();
					}
					//Apply customization options
					applyCustomizations();
					var _loc = $(document).data("localizations");
					if (mainMenu && _loc["CopyLinkText"] && mainMenu.find("li.copydirectlink").length > 0 && mainMenu.find("li.copydirectlink").find("a").length > 0) {
						mainMenu.find("li.copydirectlink").find("a").text(_loc["CopyLinkText"]);
					}
                    if(mainNav.find("li").length>0)
					   mainNav.show();
                    if(typeof window.navigationMenuItemChangeHTML != "undefined")
                    {
                        for(var item in window.navigationMenuItemChangeHTML)
                        {
                            try{
                                var val = window.navigationMenuItemChangeHTML[item];
                                $("a:exacttext('"+item+"')", mainNav).html(val);
                            }
                            catch(ex){}
                        }
                    }
				}
				//Clear current context
				window.clearContext = function () {
					$(document).removeData("currentContext");
				}
				//Retrive current context
				window.currentContext = function () {
					var curElem = $(document).data("currentContext");
					clearContext();
					if (curElem) {
						return curElem.elem;
					} else {
						return false;
					}
				}

				window.verifyUserStatus = function()
				{
					var targetUrl = unescape(window.location.toString()).replace(unescape(hashListener.getHash().toString()), "");
					bindUserName(false, function (response, username) {
						if (response == "failure") {
							window.location = "/WebInterface/login.html?link=" + targetUrl;
						}
					});
				}

				//Login status thread
				function userLoginStatusCheckThread() {
					if (!window.loginStatusThreadInterval) {
						window.loginStatusThreadInterval = setInterval(window.verifyUserStatus, 600000);
					}
				}

				//Bind user name
				function bindUserName(isInit, callBack) { /* Data to POST to receive file listing */
					var obj = {
						command: "getUsername",
						random: Math.random()
					}; /* Make a call and receive list */
					var username = "anonymous";
					$.ajax({
						type: "POST",
						url: o.ajaxCallURL,
						data: obj,
						error: function (XMLHttpRequest, textStatus, errorThrown) {
							errorThrown = errorThrown || "getUsername failed";
							$.growlUI("Error : " + errorThrown, errorThrown, o.GrowlTimeout, "", o.GrowlWithCloseButton);
							callBack("failure", username);
						},
						success: function (msg) {
							var responseText = msg;
							try {
								var response = msg.getElementsByTagName("response");
								response = IE(response[0]).textContent;
								if (response == "success") {
									username = msg.getElementsByTagName("username");
									username = IE(username[0]).textContent;
								}
								username = username || "";
								if (username == "anonymous" || username == "") {
									$(document).data("username", "anonymous");
								} else {
									$(document).data("username", username);
                                }
                                $("#crumbs").find(".userHome").text($(document).data("username"));
							} catch (ex) {
								if (callBack) {
									callBack("failure", username);
									return false;
								}
							}
							if (isInit) {
								renderButtons();
								var filesBasket = $("#filesBasket").dialog({
									title : getLocalizationKey("BasketHeaderText") || "Files in the Basket",
									autoOpen: false,
									closeOnEscape: false,
									draggable: true,
									width : 840,
									minWidth : 840,
									height : 580,
									minHeight : 580,
									modal: true,
									buttons: {},
									resizable: true,
                                    open:function(){
                                        /*if($(document).data("popupHeaderBackgroundColor") && $(document).data("popupHeaderTextColor"))
                                        {
                                            filesBasket.prev().css("background-color", getPopupColor(false, true)).css("color", getPopupColor(false, false, true));
                                            filesBasket.parent().find(".ui-widget-header").css("background","none").css("background-color", getPopupColor(false, true)).css("color", getPopupColor(false, false, true));
                                            filesBasket.parent().find(".ui-widget-content").css("background-color", getPopupColor(true));
                                        }*/
                                        if($.CrushFTP.browseAdvanced)
                                        {
                                            window.cancelDropAction(true);
                                        }
                                        filesBasket.parent().addClass("downloadBasket");
                                        var closeButton = filesBasket.parent().find(".ui-dialog-titlebar-close").show().unbind("hover");
                                        if(closeButton.parent().find("a.fullScreen").length==0)
                                        {
                                            closeButton.after('<a title="Maximize" href="#" role="button" style="float: right;margin-right: 13px;margin-top: 0px;" class="fullScreen ui-corner-all"><span class="ui-icon ui-icon-arrow-4-diag">Fullscreen</span></a>');
                                            var fullScreenLink = closeButton.parent().find("a.fullScreen").click(function(){
                                                var isFullS = filesBasket.attr("maximized");
                                                if(!isFullS)
                                                {
                                                    $(this).find("span").addClass("ui-icon-arrow-1-sw").removeClass("ui-icon-arrow-4-diag");
                                                    $(this).attr("title", "Resize to original size");
                                                    var h = window.innerHeight ? window.innerHeight : $(window).height();
                                                    var w = $(window).width() - 10;
                                                    h -= 5;
                                                    filesBasket.parent().css("position", "fixed");
                                                    filesBasket.dialog("widget").animate({
                                                        width: w+'px',
                                                        height:h+'px'
                                                      }, {
                                                      duration: 100,
                                                      step: function() {
                                                        filesBasket.dialog('option', 'position', 'top');
                                                      }
                                                    });
                                                    filesBasket.dialog('option', 'resizable', false);
                                                    filesBasket.dialog('option', 'draggable', false);
                                                    filesBasket.height(h + "px");
                                                    h -= 160;
                                                    filesBasket.find("div.filesSelectedInBasket").height(h + "px");
                                                    filesBasket.attr("maximized", "true");
                                                }
                                                else
                                                {
                                                    $(this).attr("title", "Maximize");
                                                    $(this).find("span").addClass("ui-icon-arrow-4-diag").removeClass("ui-icon-arrow-1-sw");
                                                    filesBasket.parent().css("position", "absolute");
                                                    filesBasket.dialog("widget").animate({
                                                        width: '840px',
                                                        height:'580px'
                                                      }, {
                                                      duration: 100,
                                                      step: function() {
                                                        filesBasket.dialog('option', 'position', 'center');
                                                      }
                                                    });
                                                    filesBasket.dialog('option', 'resizable', true);
                                                    filesBasket.dialog('option', 'draggable', true);
                                                    filesBasket.find("div.filesSelectedInBasket").height("420px");
                                                    filesBasket.removeAttr("maximized");
                                                }
                                                return false;
                                            });
                                            if(window.basketKeepMaximized)
                                                fullScreenLink.trigger("click");
                                        }
                                        else
                                        {
                                            if(filesBasket.attr("maximized"))
                                            {
                                                filesBasket.removeAttr("maximized");
                                            }
                                            else
                                            {
                                                filesBasket.attr("maximized", "true");
                                            }
                                            closeButton.parent().find("a.fullScreen").trigger("click");
                                        }
                                    },
                                    close : function()
                                    {
                                        if($.CrushFTP.browseAdvanced)
                                        {
                                            window.showDropArea();
                                        }
                                    }
								});
							} else {
								if (callBack) {
									callBack(response, username);
								}
							}
						}
					});
				}

				//Generate random password
				window.generateRandomPassword = function(length) {
					length = length || 8;
					var randomId = "";
					var possible = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
					for (var i = 0; i < length; i++)
					randomId += possible.charAt(Math.floor(Math.random() * possible.length));
					return randomId;
				}

				window.bindDataToForm = function(_panel, curItem){
					var attrToUse = "name";
					curItem = curItem.split("&");
					_panel.find("input[type='text'],input[type='password'], textarea, select").each(function(){
						if($(this).attr(attrToUse))
						{
							if(curItem)
							{
								for(var i=0; i<curItem.length;i++)
								{
									var elem = curItem[i].split("=");
									if(elem[0] == $(this).attr(attrToUse))
									{
										$(this).val(crushFTPTools.decodeURILocal(elem[1]));
									}
								}
							}
							else
							{
								$(this).val("");
							}
						}
					});
					_panel.find("input[type='checkbox']").each(function(){
						if($(this).attr(attrToUse))
						{
							if(curItem)
							{
								var flag = false;
								for(var i=0; i<curItem.length;i++)
								{
									var elem = curItem[i].split("=");
									if(elem[0] == $(this).attr(attrToUse) && crushFTPTools.decodeURILocal(elem[1]) == $(this).val())
									{
										flag = true;
									}
								}
								if(flag)
									$(this).attr("checked", "checked");
								else
									$(this).removeAttr("checked");
							}
							else
								$(this).removeAttr("checked");
						}
					});
					_panel.find("input[type='radio']").each(function(){
						if($(this).attr(attrToUse))
						{
							if(curItem)
							{
								var flag = false;
								for(var i=0; i<curItem.length;i++)
								{
									var elem = curItem[i].split("=");
									if(elem[0] == $(this).attr(attrToUse) && crushFTPTools.decodeURILocal(elem[1]) == $(this).val())
									{
										flag = true;
									}
								}
								if(flag)
								{
									$(this).parent().find("input[type='radio']").removeAttr("checked");
									$(this).attr("checked", "checked");
								}
								else
									$(this).removeAttr("checked");
							}
							else
								$(this).removeAttr("checked");
						}
					});
				};

				//Bind user customization info
				function bindUserCustomizationInfo(callback) {
                    if(window.retryGetUserInfo && window.retryGetUserInfo > 3)
                    {
                        alert("There was a problem while loading user info, you will be logged out.\n\n Try after re-login, if problem persists contact administrator");
                        doLogout();
                        return false;
                    }
					var mainNav = $("#mainNavigation").hide();

                    var obj = {
						command: "getUserInfo",
						path: crushFTPTools.encodeURILocal(hashListener.getHash().toString().replace("#", "")),
						random: Math.random()
					};

                    function applyUserInfoToLayout(msg)
                    {
                        var responseText = msg;
                        var buttons = msg.getElementsByTagName("buttons_subitem");
                        //Go through various customizations option and show items based on customization
                        if (msg.getElementsByTagName("expire_password_when")[0]) {
                            var expire_password_when = IE(msg.getElementsByTagName("expire_password_when")[0]).textContent;
                            if (expire_password_when && expire_password_when.length > 0) $.growlUI(getLocalizationKey("PasswordExpiringMsgText"), expire_password_when, o.GrowlTimeout, "growlError", o.GrowlWithCloseButton);
                        }
                        var user_priv_options = IE(msg.getElementsByTagName("user_priv_options")[0]).textContent;
                        var display_alt_logo = IE(msg.getElementsByTagName("display_alt_logo")[0]).textContent;
                        if(display_alt_logo && display_alt_logo == "false")
                        {
                            $(document).data("disableDirectoryLogo", true);
                        }
                        $(document).data("user_priv_options", user_priv_options);
                        if (user_priv_options.indexOf("(SITE_PASS)") >= 0) {
                            $("#changepasswordPanel").show();
                            $("#new_password1").val("");
                            $("#changepasswordPanel").find("#btnGeneratePassword").unbind().click(function () {
                                var passwords = [];
                                var maxChars = $(document).data("random_password_length") || 8;
                                var randomPass = function(length, numeric, possible){
                                    length = length || 8;
                                    var randomId = "";
                                    possible = possible || "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
                                    if(numeric)
                                    {
                                        possible = "0123456789";
                                    }
                                    for( var i=0; i < length; i++ )
                                        randomId += possible.charAt(Math.floor(Math.random() * possible.length));
                                    return randomId;
                                }
                                passwords.push(randomPass(maxChars));
                                var minNumeric = $(document).data("min_password_numbers") || 0;
                                var minLower = $(document).data("min_password_lowers") || 0;
                                var minUpper = $(document).data("min_password_uppers") || 0;
                                var minSpecial = $(document).data("min_password_specials") || 0;
                                if(minNumeric>0 || minLower>0 || minUpper>0 || minSpecial>0)
                                {
                                    passwords = [];
                                    if(minNumeric>0)
                                    {
                                        passwords.push(randomPass(minNumeric, true));
                                    }
                                    if(minLower>0)
                                    {
                                        passwords.push(randomPass(minLower, false, 'abcdefghijklmnopqrstuvwxyz'));
                                    }
                                    if(minUpper>0)
                                    {
                                        passwords.push(randomPass(minUpper, false, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'));
                                    }
                                    if(minSpecial>0)
                                    {
                                        passwords.push(randomPass(minSpecial, false, '!$^&*()_-+=[]{};,.<>?~'));
                                    }
                                }
                                passwords.sort(function(a,b){ return( parseInt( Math.random()*10 ) %2 );});
                                var pass = passwords.join("");
                                pass = pass.shuffle();
                                if(pass.length>maxChars)
                                {
                                    pass = pass.substr(0, maxChars);
                                }
                                else if(pass.length<maxChars)
                                {
                                    pass += randomPass(maxChars - pass.length, true);
                                }
                                pass = pass.shuffle();
                                $("#generated_password").val(pass);
                                $("#passwordGeneratePanel").show();
                                return false;
                            });
                            $("#passwordGeneratePanel").hide();
                            $("#changepasswordPanel").find("a.usePassword").unbind().click(function () {
                                $("#new_password1").val($("#generated_password").val());
                                $("#new_password2").focus();
                                return false;
                            });
                            $("#changepasswordPanel").find("a.cancelPassword").unbind().click(function () {
                                $("#generated_password").val("");
                                $("#passwordGeneratePanel").hide();
                                return false;
                            });
                        } else {
                            $("#changepasswordPanel").hide();
                        }

                        var menuListBar = [];
                        var menuListContextMenu = [];
                        for (var x = 0; x < buttons.length; x++) {
                            var opt = {};
                            opt.name = IE(buttons[x].getElementsByTagName("key")[0]).textContent;
                            opt.text = IE(buttons[x].getElementsByTagName("value")[0]).textContent;
                            opt.requiredPriv = IE(buttons[x].getElementsByTagName("requiredPriv")[0]).textContent;
                            if (IE(buttons[x].getElementsByTagName("for_menu")[0]).textContent == "true") {
                                menuListBar.push(opt);
                            }
                            if (IE(buttons[x].getElementsByTagName("for_context_menu")[0]).textContent == "true") {
                                menuListContextMenu.push(opt);
                            }
                        }
                        $(document).data("menuList", menuListBar);
                        $(document).data("menuListContextMenu", menuListContextMenu);
                        var customizationItems = msg.getElementsByTagName("customizations_subitem");
                        var customizations = [];
                        for (var x = 0; x < customizationItems.length; x++) {
                            var opt = {};
                            opt.key = IE(customizationItems[x].getElementsByTagName("key")[0]).textContent;
                            opt.value = "";
                            try {
                                opt.value = IE(customizationItems[x].getElementsByTagName("value")[0]).textContent;
                            } catch (e) {} //value may not exist.
                            customizations.push(opt);
                        }
                        $(document).data("customizations", customizations);
                        $(document).data("unique_upload_id", IE(msg.getElementsByTagName("unique_upload_id")[0]).textContent);

                        $(document).data("random_password_length", IE(msg.getElementsByTagName("random_password_length")[0]).textContent);
                        $(document).data("min_password_length", IE(msg.getElementsByTagName("min_password_length")[0]).textContent);
                        $(document).data("min_password_numbers", IE(msg.getElementsByTagName("min_password_numbers")[0]).textContent);
                        $(document).data("min_password_lowers", IE(msg.getElementsByTagName("min_password_lowers")[0]).textContent);
                        $(document).data("min_password_uppers", IE(msg.getElementsByTagName("min_password_uppers")[0]).textContent);
                        $(document).data("min_password_specials", IE(msg.getElementsByTagName("min_password_specials")[0]).textContent);

                        applyCustomizations();
                        displayWelcomeNote();
                        if (!$(document).data("slideShowOnly")) {
                            if (currentView() == "Thumbnail") showTree($("#filesContainerDiv"), crushFTPTools.encodeURILocal(o.root), false);
                            else showTree($("#filesContainer"), crushFTPTools.encodeURILocal(o.root), false);
                        }
                        if(callback)
                            callback();
                    }

					$.ajax({
						type: "POST",
						url: o.ajaxCallURL,
						data: obj,
						error: function (XMLHttpRequest, textStatus, errorThrown) {
							errorThrown = errorThrown || "getUserInfo failed";
							$.growlUI("Error : " + errorThrown, errorThrown, o.GrowlTimeout, "", o.GrowlWithCloseButton);
                            if(!window.retryGetUserInfo)
                                window.retryGetUserInfo = 0;
                            window.retryGetUserInfo+=1;
                            bindUserCustomizationInfo();
						},
						success: function (msg) {
                            if(!msg || msg.getElementsByTagName("userInfo").length == 0)
                            {
                                if(!window.retryGetUserInfo)
                                    window.retryGetUserInfo = 0;
                                window.retryGetUserInfo+=1;
                                bindUserCustomizationInfo();
                            }
                            else
                                applyUserInfoToLayout(msg);
						}
					});
				}

				//Show welcome note
				function displayWelcomeNote() {
					var $elem = $("div#welcomeFormPanel");
					var userName = $(document).data("username");
					var buttonText = getLocalizationKey("WelcomeFormOkButtonText");
                    var _formShown = $.cookie(o.CookieWelcomeNote + "_" + userName);
                    if(_formShown && _formShown.length>0)
                        _formShown = "true";
                    else
                        _formShown = "false";

					//Get form from server named messageForm, build form if exist and show to user
					getCustomForm("messageForm", function (data, hasForm, formName, showAlways) {
						if (hasForm) {
							if (!showAlways) //If not to show always and shown already once, do nothing
							{
								var formShown = $.cookie(o.CookieWelcomeNote + "_" + userName + "_" + formName);
								if (formShown && formShown.length > 0) return false;
							}
							//Build form and show in a popup
							var welcomeForm = $("div.welcomeForm", "#welcomeFormPanel");
							welcomeForm.html("<form id='frmWelcome' method='post' target='dummyIframe' action='/WebInterface/function/?command=discard'>" + data + "</form>").find("table").css("text-align", "left");
							setCustomFormFieldAttributes(welcomeForm)
							attachCalendarPopup(welcomeForm);
							$("button#resetPasteForm", welcomeForm).unbind().click(function (event) {
								welcomeForm.clearForm();
								event.stopPropagation();
								event.preventDefault();
							});
							welcomeForm.find("input").keydown(function (evt) {
								var evt = (evt) ? evt : ((event) ? event : null);
								if (evt.keyCode == 13) {
									$("button.submitForm", welcomeForm).click();
									return false;
								} else if (evt.keyCode == 27) {
									$("button#resetPasteForm", welcomeForm).click();
									return false;
								}
							});
							//Display error message for welcome note
							function displayError(msg) {
								var form = $("table.customForm", welcomeForm);
								if (form.prev().hasClass("attention")) {
									form.prev().remove();
								}
								form.before("<div class='attention'>" + msg + "</div>");
								form.prev().css("float", "none");
							}
							//Submit action
							$("button.submitForm", welcomeForm).unbind().click(function (event) {
								welcomeForm.find("form").submit();
								event.stopPropagation();
								event.preventDefault();
								if (!validateForm("", welcomeForm)) {
									return;
								}
								var messageForm = welcomeForm;
								var formClone = messageForm.find("form");
								messageForm = serializeForm(formClone[0]);
								if (messageForm.length == 0) {
									$.unblockUI();
									return;
								}
								messageForm += "&command=messageForm&random=" + Math.random();
								var obj = messageForm;
								welcomeForm.find("h2").addClass("spinner");
								$.ajax({
									type: "POST",
									url: o.ajaxCallURL,
									data: obj,
									error: function (XMLHttpRequest, textStatus, errorThrown) {
										errorThrown = errorThrown || "messageForm failed";
										displayError("Error : " + errorThrown);
									},
									success: function (msg) {
										$("#welcomeFormPanel").find("h2").removeClass("spinner");
										var responseText = msg;
										var response = msg.getElementsByTagName("response");
										response = IE(response[0]).textContent;
										if (response.toLowerCase() == "success") {
											var options = {
												path: '/',
												expires: 365
											};
                                            if (!showAlways) {
												$.cookie(o.CookieWelcomeNote + "_" + userName + "_" + formName, true, options);
											}
                                            $.cookie(o.CookieWelcomeNote + "_" + userName, true, options);
											$.unblockUI();
										} else {
											displayError(getLocalizationKey("WelcomeNoteSubmitFormFailureMsgText"));
										}
									}
								});
								return false;
							});
							$.blockUI({
								message: $elem,
								css: {
									border: 'none',
									width: '650px',
									padding: '15px',
									color: '#000',
									'border': '1px solid ' + getPopupColor(),
									'background-color': getPopupColor(true),
									'margin-left': '-320px',
									left: '50%',
									position: 'absolute',
									top: '10%',
									'-webkit-border-radius': '10px',
									'-moz-border-radius': '10px',
									opacity: 1,
									'-webkit-box-shadow': '2px 5px 5px #373434',
									'-moz-box-shadow': '2px 5px 5px #373434'
								}
							});
						}
					}, buttonText, _formShown);
				}

				//Load directory preview in top of window corner
				function loadDirectoryPreview() {
					var destinationPath = crushFTPTools.encodeURILocal(hashListener.getHash().toString().replace("#", ""));
					destinationPath = destinationPath || "/";
					$("div.directoryPreview").hide();
					var ok = true;
					if (!$(document).data("disableDirectoryLogo")) $("div.directoryPreview").empty().append("<img id='directoryPreviewImg' src='" + destinationPath + ".logo.png' />");
					$('#directoryPreviewImg').load(function () {
						$('div.directoryPreview').show();
					});
				}

				//Get localization key
				function getLocalizationKey(key) {
					var _loc = $(document).data("localizations");
					var defaultText = localizations[key];
					if (_loc && _loc[key]) {
						defaultText = _loc[key];
					}
					return defaultText;
				}
				window.getLocalizationKeyExternal = function(key)
				{
					return getLocalizationKey(key);
				}

                window.localizeServerMessage = function(message)
                {
                    var valToReplace = [],
                        rxp = /{([^}]+)}/g,
                        curMatch;
                    while(curMatch = rxp.exec(message)) {
                        valToReplace.push(curMatch[1]);
                    }
                    if(valToReplace.length>0)
                    {
                        for(var i=0;i<valToReplace.length;i++)
                        {
                            var key = valToReplace[i];
                            var locVal = getLocalizationKey(key);
                            if(locVal)
                            {
                                message = message.replaceAll("{"+key+"}", locVal);
                            }
                        }
                    }
                    return message;
                }

				//Apply localizations
				window.applyLocalizations = function () {
					var _loc = $(document).data("localizations"); //All localizations from cache
					if (_loc) {
						for (var i in _loc) //Loop through localizations
						{
							if (i) {
								var key = i.toString();
								var val = _loc[i].toString();
								if (key && (val || val == "") && key!="slideshow") {
									//If button or input, set value
									if (key.toLowerCase().indexOf("button") >= 0 || key.toLowerCase().indexOf("input") >= 0) {
										$("." + key).val(val);
									} else if (key.toLowerCase().indexOf("byclass") >= 0 || key.toLowerCase().indexOf("multiple") >= 0) //If localization is for multiple items, set html
									{
										$("." + key).html(val);
									}else if (key.toLowerCase().indexOf("settitle") >= 0 ) //If localization is for tooltip title
									{
                                        if (key.toLowerCase().indexOf("class") >= 0)
                                          $("." + key).attr("title", val);
                                        else
										  $("#" + key).attr("title", val);
									} else {
										$("#" + key).html(val);
									}
								}
							}
						}
						//Various hard coded localization
						var date1 = $("select#date1_action", "div#searchDiv");
						date1.find("option[value='after']").text(getLocalizationKey("SearchFormModifiedOptionAfterText"));
						date1.find("option[value='before']").text(getLocalizationKey("SearchFormModifiedOptionBeforeText"));
						var date2 = $("select#date2_action", "div#searchDiv");
						date2.find("option[value='after']").text(getLocalizationKey("SearchFormModifiedOptionAfterText"));
						date2.find("option[value='before']").text(getLocalizationKey("SearchFormModifiedOptionBeforeText"));
						var sizeDropdown = $("select#size1_action", "div#searchDiv");
						sizeDropdown.find("option[value='bigger than']").text(getLocalizationKey("SearchFormSizeOptionBiggerThanText"));
						sizeDropdown.find("option[value='smaller than']").text(getLocalizationKey("SearchFormSizeOptionSmallerThanText"));
						var typeDropdown = $("select#type1_action", "div#searchDiv");
						typeDropdown.find("option[value='file']").text(getLocalizationKey("SearchFormItemTypeOptionFileText"));
						typeDropdown.find("option[value='folder']").text(getLocalizationKey("SearchFormItemTypeOptionFolderText"));
						$("#filesContainer").find("td.thName").html(getLocalizationKey("TreeviewHeaderNameText"));
						$("#filesContainer").find("td.thSize").html(getLocalizationKey("TreeviewHeaderSizeText"));
						$("#filesContainer").find("td.thModified").html(getLocalizationKey("TreeviewHeaderModifiedText"));
						$("#filesContainer").find("td.thKeywords").html(getLocalizationKey("TreeviewHeaderKeywordsText"));
						updatePageSizeOnLayout();
					}
				}

				//Apply customizations
				function applyCustomizations() {
					var customizations = $(document).data("customizations"); //Customizations from cache
					if (!customizations) return;
                    if(window.hideFilter)
                        window.hideFilter("false");
                    if(window.hideCheckBoxColumn)
                        window.hideCheckBoxColumn();
					var advUpload = $("#advancedBrowseOptionsDiv");
					var nativeUpload = $("#nativeBrowseOptionsDiv");
					var filesContainer = $("#filesContainer");
					for (var i=0;i<customizations.length;i++) //Loop through customizations
					{
						var custItem = customizations[i];
						//Switch from key and apply customization based on key and value
						switch (custItem.key) {
						case "redirectRoot":
							//Redirect root
							window.redirectRoot = custItem.value;
							break;
						case "shareyyyymmdd":
							// If share window to yse yyyymmdd format
							window.Shareyyyymmdd = custItem.value == "true";
							break;
                        case "shareddmmyyyy":
                            // If share window to yse ddmmyyyy format
                            window.Shareddmmyyyy = custItem.value == "true";
                            break;
						case "customformyyyymmdd":
							// If custom forms has to use yyyymmdd format for date
							window.CustomFormyyyymmdd = custItem.value == "true";
							break;
						case "logo":
							//Logo to show on layout
							var logoLink = custItem.value;
							if(logoLink.toLowerCase().indexOf("http://")<0 && logoLink.toLowerCase().indexOf("https://")<0)
							{
								logoLink = "/WebInterface/images/" + logoLink;
							}
							if($("div.logo", "#header").find("img").length>0)
								$("div.logo", "#header").find("img").replaceWith("<img src='" + logoLink+ "' />");
							else
								$("div.logo", "#header").append("<img src='" + logoLink + "' />");
							break;
						case "linkOnLogo":
							// Hyperlink on logo
							var link = custItem.value;
							if (link) {
								if (!$("div.logo").find("img").parent().attr("href")) {
                                    if(link == "#")
                                        $("div.logo").find("img").wrap("<a href='" + link + "'></a>");
                                    else
									   $("div.logo").find("img").wrap("<a target='_blank' href='" + link + "'></a>");
								} else {
									$("div.logo").parent().attr("href", link);
								}
								$("div.logo").find("img").css("border", "none");
							}
							break;
						case "logoAlign":
							//Allignment of logo on screen
							if (custItem.value == "middle") {
								$("div.logo").css("float", "none").addClass("logoCenter").parent().css("text-align", "center");
							} else if (custItem.value == "right") {
								$("div.logo").css("float", "right").addClass("logoCenter").parent().css("text-align", "right");
							} else {
								$("div.logo").css("float", "left").removeClass("logoCenter").parent().css("text-align", "left");
							}
							break;
						case "title":
							//Document title
							document.title = custItem.value;
							break;
                        case "slideshowWindowTitle":
                            if(window.forSlideshow)
                            {
                                document.title = custItem.value;
                            }
                            break;
						case "header":
							//Header on layout
							$("div#headerText").html(custItem.value);
							break;
                        case "hideUploadBar" :
                            //Hide new upload bar
                            if (custItem.value.toLowerCase() == "true")
                            {
                                $.cssRule({
                                    "#fileUploadBarHolder, #viewFileQueue, #globalProgressBar": [
                                        ["display", "none !important;"]
                                    ]
                                });

                                $("#fileQueueInfo").removeClass("ui-widget-content ui-corner-all").css("box-shadow", "none").css("-webkit-box-shadow", "none").css("-moz-box-shadow", "none").css("border", "none");

                                $.CrushFTP.uploadBarHidden = true;
                            }
                            break;
                        case "blockUploadingDirs":
                            //Uploading dir is disabled
                            window.blockUploadingDirs = custItem.value.toLowerCase() == "true";
                            break;
                        case "noTimeoutUploadedNote":
                            //Uploading dir is disabled
                            window.noTimeoutUploadedNote = custItem.value.toLowerCase() == "true";
                            break;
                        case "noFilesOverlayBGColor":
                            //No files available msg overlay BG color
                            window.noFilesOverlayBGColor = custItem.value;
                            break;
                        case "noFilesOverlayTransparency":
                            //No files available msg overlay BG color
                            window.noFilesOverlayTransparency = custItem.value;
                            break;
						case "headerTextColor":
							//Header text color
							$("#headerContent").css("color", custItem.value);
							break;
                        case "growlTextColor":
                            //Growl message text color
                            $.blockUI.defaults.growlCSS.color = custItem.value;
                            break;
                        case "growlBackgroundColor":
                            //Growl message BG color
                            $.blockUI.defaults.growlCSS.backgroundColor = custItem.value;
                            break;
						case "headerTextSize":
							//Header text size
							$("#headerContent").css("font-size", custItem.value);
							break;
						case "headerTextStyle":
							//Header text style
							if (custItem.value.indexOf("bold") >= 0) {
								$("#headerContent").css("font-weight", custItem.value);
							} else {
								$("#headerContent").css("font-style", custItem.value);
							}
							break;
						case "headerTextAlign":
							//Header text aling
							$("div#headerText").css("float", custItem.value);
							break;
						case "headerBackgroundColor":
							//Header background color
							$("#headerContent").css("background-color", custItem.value);
							break;
						case "footer":
							//Footer html
							$("div.footerContent").html(custItem.value);
							break;
						case "footerTextColor":
							//Footer text color
							$.cssRule({
								"div.footerContent": [
									["color", custItem.value]
									]
							});
							break;
						case "footerTextSize":
							//Footer text size
							$.cssRule({
								"div.footerContent": [
									["font-size", custItem.value]
									]
							});
							break;
						case "footerTextStyle":
							//Footer text style
							if (custItem.value.indexOf("bold") >= 0) {
								$.cssRule({
									"div.footerContent": [
										["font-weight", custItem.value]
										]
								});
							} else {
								$.cssRule({
									"div.footerContent": [
										["font-style", custItem.value]
										]
								});
							}
							break;
						case "footerTextAlign":
							//Footer text alignment
							$.cssRule({
								"div.footerContent": [
									["text-align", custItem.value]
									]
							});
							break;
						case "footerBackgroundColor":
							//Footer background color
							$.cssRule({
								"div.footerContent": [
									["background-color", custItem.value]
									]
							});
							break;
						case "uploadOnly":
							//If layout need to be upload only
							if (custItem.value.toLowerCase() == "true") {
								makeItUploadOnly();
							}
							break;
						case "slideShowOnly":
							//If layout need to be slideshow only
							if (custItem.value.toLowerCase() == "true") {
								if (!window.forSlideshow) {
									makeItSlideShowOnly();
								}
							}
							break;
                        case "replaceListingWithPage":
                            //If layout need to be replaced with HTML file
                            if (custItem.value.toLowerCase() != "") {
                                window.listingHTMLPage = custItem.value;
                            }
                            break;
						case "popupBackgroundColor":
							//Popup background color
							$(document).data("popupBackgroundColor", custItem.value);
                             $.cssRule({
                                "#searchDiv tr.tblAltRow, #searchDiv tr.tblRow": [
                                    ["background-color", custItem.value]
                                ]
                            });
                            if(!$(document).data("slideShowOnly"))
                            {
                                $.fn.media.defaults.bgColor = custItem.value;
                            }
							break;
                        case "popupOverlayBackgroundColor":
                            //Popup background color
                            $(document).data("popupOverlayBackgroundColor", custItem.value);
                            $.cssRule({
                                ".blockUI.blockOverlay, div.ui-widget-overlay": [
                                    ["background", custItem.value + " !important"]
                                ]
                            });
                            break;
						case "popupBorderColor":
							//Popup border color
							$(document).data("popupBorderColor", custItem.value);
                            $.cssRule({
                                ".ui-dialog": [
                                    ["border-color", custItem.value]
                                ]
                            });
							break;
                        case "popupHeaderBackgroundColor":
                            //Popup header BG color
                            $(document).data("popupHeaderBackgroundColor", custItem.value);
                            $.cssRule({
                                ".blockUI .popupHeader": [
                                    ["background-color", custItem.value]
                                    ]
                            });
                            break;
                        case "popupHeaderTextColor":
                            //Popup header text color
                            $.cssRule({
                                ".blockUI .popupHeader": [
                                    ["color", custItem.value]
                                    ]
                            });
                            break;
                        case "quickSharePopupBackgroundColor":
                             $.cssRule({
                                ".publishStatusDialog, .publishStatusDialog div, .publishStatusDialog .ui-dialog-content, .publishStatusDialog .ui-widget-content, .publishStatusDialog .ui-dialog-buttonpane": [
                                    ["background-color", custItem.value]
                                ]
                            });
                            break;
                        case "quickSharePopupHeaderBackgroundColor":
                            //Popup header BG color
                            $.cssRule({
                                ".publishStatusDialog .ui-dialog-titlebar, .publishStatusDialog .ui-widget-header": [
                                    ["background", custItem.value]
                                    ]
                            });
                            break;
                        case "quickSharePopupHeaderTextColor":
                            //Popup header text color
                            $.cssRule({
                                ".publishStatusDialog .ui-dialog-titlebar, .publishStatusDialog .ui-widget-header": [
                                    ["color", custItem.value]
                                    ]
                            });
                            break;
                        case "quickSharePopupHeaderBorderColor":
                            //Popup header border color
                            $.cssRule({
                                ".publishStatusDialog .ui-dialog-titlebar, .publishStatusDialog .ui-widget-header": [
                                    ["border-color", custItem.value]
                                    ]
                            });
                            break;
                        case "quickShareSendEmail":
                            if (custItem.value == "true")
                            {
                                window.quickShareSendEmail = true;
                            }
                            break;
						case "mainBackgroundColor":
							//Body background color
							$.cssRule({
								"body": [
									["background-color", custItem.value]
									]
							});
							break;
                        case "mainTextColor":
                            //Body text color
                            $.cssRule({
                                "body, a, a:visited, a:active,.viewSelectorPanel a.viewlink, .viewSelectorPanel a.viewlink:visited,.filterPanel a, .filterPanel a:visited": [
                                    ["color", custItem.value]
                                    ]
                            });
                            break;
						case "mainBackgroundImage":
							//Body background image
                            var imgLink = custItem.value;
                            if(imgLink.toLowerCase().indexOf("http://")<0 && imgLink.toLowerCase().indexOf("https://")<0)
                            {
                                imgLink = "/WebInterface/images/" + imgLink;
                            }
							$.cssRule({
								"body": [
									["background-image", "url(" + imgLink + ")"]
									]
							});
							break;
                        case "mainBackgroundImageNoRepeat":
                            //Body background image, no-repeat
                            if (custItem.value == "true") {
                                $.cssRule({
                                    "body": [
                                        ["background-repeat", "no-repeat"]
                                        ]
                                });
                            }
                            break;
						case "mainBorderColor":
							//Body border color
							$.cssRule({
								"body": [
									["border", "1px solid " + custItem.value]
									]
							});
							break;
						case "headerButtonBarBackgroundColor":
							//header button bar background color
							$.cssRule({
								"#mainNavigation": [
									["background-color", custItem.value]
									]
							});
							break;
						case "buttonFontColor":
							//Main navigation button font color
							$.cssRule({
								"ul.topnav li a.menuLink": [
									["color", custItem.value + " !important"]
									]
							});
							break;
						case "buttonHoverFontColor":
							//Main navigation button font color on hover
							$.cssRule({
								"ul.topnav li a.menuLink:hover": [
									["color", custItem.value + " !important"]
									]
							});
							break;
						case "buttonBackgroundColor":
							//Main navigation button font background color
							$.cssRule({
								"#mainNavigation li": [
									["background-color", custItem.value + " !important"]
									]
							});
							break;
						case "buttonHoverColor":
							//Main navigation button background color on hover
							$.cssRule({
								"#mainNavigation a.menuLink:hover": [
									["background-color", custItem.value + " !important"]
									]
							});
							break;
						case "buttonBackgroundImage":
							//Main navigation button background image
                            var imgLink = custItem.value;
                            if(imgLink.toLowerCase().indexOf("http://")<0 && imgLink.toLowerCase().indexOf("https://")<0)
                            {
                                imgLink = "/WebInterface/images/" + imgLink;
                            }
							$.cssRule({
								"#mainNavigation a.menuLink": [
									["background-image", "url(" + imgLink + ")" + " !important"],
									["background-repeat", "repeat-x" + " !important"]
									]
							});
							break;
						case "buttonHoverImage":
							//Main navigation button background image on hover
                            var imgLink = custItem.value;
                            if(imgLink.toLowerCase().indexOf("http://")<0 && imgLink.toLowerCase().indexOf("https://")<0)
                            {
                                imgLink = "/WebInterface/images/" + imgLink;
                            }
							$.cssRule({
								"#mainNavigation a.menuLink:hover": [
									["background-image", "url(" + imgLink + ")"],
									["background-repeat", "repeat-x"]
									]
							});
							break;
						case "listBackgroundColor":
							//Item listing background color
							$.cssRule({
								"#filesListing, #basketFilesContainer, div.filesSelectedInBasket, #basketFilesContainerThumb, div.filesSelectedInBasket div": [
									["background-color", custItem.value]
									]
							});
							break;
						case "listTextColor":
							//Item listing font/text color
							$.cssRule({
								"#filesListing, #basketFilesContainer": [
									["color", custItem.value]
									]
							});
							$.cssRule({
								"#filesListing a, #basketFilesContainer a": [
									["color", custItem.value]
									]
							});
							break;
						case "listTextColorHover":
							//Item listing font/text color on hover
							$.cssRule({
								"#filesListing tr:hover, #basketFilesContainer tr:hover": [
									["color", custItem.value]
									]
							});
							$.cssRule({
								"#filesListing tr:hover a, #basketFilesContainer tr:hover a": [
									["color", custItem.value]
									]
							});

							$.cssRule({
								"#filesListing a:hover, #basketFilesContainer a:hover": [
									["color", custItem.value]
									]
							});
							break;
						case "listTextSize":
							//Item listing text size
							$.cssRule({
								"#filesListing,tr.jqueryFileTree, #filesListing a, #basketFilesContainer": [
									["font-size", custItem.value]
									]
							});
							break;
						case "listTextStyle":
							//Item listing text style ie. bold, italic etc
							if (custItem.value.indexOf("bold") >= 0) {
								$.cssRule({
									"#filesListing,tr.jqueryFileTree, #filesListing a, #basketFilesContainer, #basketFilesContainer a": [
										["font-weight", custItem.value]
										]
								});
							} else {
								$.cssRule({
									"#filesListing,tr.jqueryFileTree, #filesListing a, #basketFilesContainer, #basketFilesContainer a": [
										["font-style", custItem.value]
										]
								});
							}
							break;
						case "listHeaderBackgroundColor":
							//Item listing header background color
							$.cssRule({
								"#filesListing td.header, #basketFilesContainer td.header": [
									["background-color", custItem.value]
									]
							});
							break;
						case "listHeaderTextColor":
							//Item listing header text color
							$.cssRule({
								"#filesListing td.header, #basketFilesContainer td.header": [
									["color", custItem.value]
									]
							});
							break;
						case "listHeaderTextSize":
							//Item listing header text size
							$.cssRule({
								"#filesListing td.header, #basketFilesContainer td.header": [
									["font-size", custItem.value]
									]
							});
							break;
						case "listHeaderTextStyle":
							//Item listing header text style
							if (custItem.value.indexOf("bold") >= 0) {
								$.cssRule({
									"#filesListing td.header, #basketFilesContainer td.header": [
										["font-weight", custItem.value]
										]
								});
							} else {
								$.cssRule({
									"#filesListing td.header, #basketFilesContainer td.header": [
										["font-style", custItem.value]
										]
								});
							}
							break;
						case "listDefaultSortColumnIndex":
							//Item listing default sorting column
							$(document).data("listDefaultSortColumnIndex", custItem.value);
							break;
						case "listDefaultSortDirection":
							//Item listing default sort direction
							$(document).data("listDefaultSortDirection", custItem.value);
							break;
						case "listAlternateColor":
							//Item listing alternate item row background color
							$.cssRule({
								".jqueryFileTreeAlt": [
									["background-color", custItem.value + ""]
									]
							});
							break;
						case "listHoverColor":
							//Item listing background color on hover
							$.cssRule({
								".rowHover td, .rowHoverFixed td": [
									["background-color", custItem.value + " !important"]
									]
							});
							break;
						case "tooltipBackgroundColor":
							//Tooltip's background color
							$.cssRule({
								".tipsy-inner": [
									["background-color", custItem.value]
									]
							});
							break;
						case "tooltipTextColor":
							//Tooltip's text color
							$.cssRule({
								".tipsy-inner": [
									["color", custItem.value]
									]
							});
							break;
                        case "useFilterForSearch":
                            if(custItem.value == "true")
                            {
                                window.useFilterForSearch = true;
                            }
                            break;
                        case "hideFilterPanel":
                            // Hide filter
                            window.hideFilter(custItem.value);
                            var varHideFilter = $.cookie(o.CookieHideFilter);
                            varHideFilter = varHideFilter == "true";
                            if (varHideFilter) {
                                $("#hideFilter").attr("checked", "checked");
                            } else {
                                $("#hideFilter").removeAttr("checked");
                            }
                            break;
						case "CHECK_COL":
							//Enable/disable checkbox column
							$(document).data("disableCheckCol", custItem.value);
                            if (custItem.value == "true") {
                                $("#hideCheckBoxColumn").attr("checked", "checked");
                            } else {
                                $("#hideCheckBoxColumn").removeAttr("checked");
                            }
                            window.hideCheckBoxColumn(custItem.value == "true");
							break;
						case "NAME_COL":
							//Enable/disable name column
							$(document).data("disableNameCol", custItem.value);
							break;
						case "SIZE_COL":
							//Enable/disable size column
							$(document).data("disableSizeCol", custItem.value);
							break;
						case "MODIFIED_COL":
							//Enable/disable modified column
							$(document).data("disableModifiedCol", custItem.value);
							break;
						case "KEYWORDS_COL":
							//Enable/disable keywords column
							$(document).data("disableKeywordsCol", custItem.value);
							break;
                        case "enableFolderPreview" :
                            if (custItem.value == "true")
                            {
                                window.enableFolderPreview = true;
                            }
                            break;
                        case "noCopyLinkOnContextMenu" :
                            if (custItem.value == "true")
                            {
                                window.noCopyLinkOnContextMenu = true;
                            }
                            break;
						case "NAME_COL_TEXT":
							//name column header text
							localizations.TreeviewHeaderNameText =  custItem.value;
							filesContainer.find("td[colName='name']").text(custItem.value);
							break;
						case "SIZE_COL_TEXT":
							//size column header text
							localizations.TreeviewHeaderSizeText =  custItem.value;
							filesContainer.find("td[colName='size']").text(custItem.value);
							break;
						case "MODIFIED_COL_TEXT":
							//modified column header text
							localizations.TreeviewHeaderModifiedText =  custItem.value;
							filesContainer.find("td[colName='modified']").text(custItem.value);
							break;
						case "KEYWORDS_COL_TEXT":
							//keywords column header text
							localizations.TreeviewHeaderKeywordsText =  custItem.value;
							filesContainer.find("td[colName='keywords']").text(custItem.value);
							break;
						case "BROWSER_UPLOAD_START_TEXT":
							//Browser upload windo "start upload" button text to display
							$("#browserFileUpload").find("#submitAction").find("a.upload").text(custItem.value);
							break;
						case "shareThumbnail":
							//Settings to share thumbnail or not
							$(document).data("shareThumbnail", custItem.value);
							break;
						case "autoShareUploadedItem":
							//Auto share uploaded item
							$(document).data("autoShareUploadedItem", custItem.value);
							break;
                        case "disableShareForUploadedItem":
                            //Disable share from uploaded item
                            $(document).data("disableShareForUploadedItem", custItem.value);
                            break;
                        case "shareMethodUploadedItem":
                            //Default method to use while sharing uploaded item
                            $(document).data("shareMethodUploadedItem", custItem.value);
                            break;
                        case "defaultShareMethod":
                            //Default method to use while sharing
                            $(document).data("defaultShareMethod", custItem.value);
                            break;
                        case "shareWindowNoUserInfoAfterShare":
                            if (custItem.value == "true")
                            {
                                window.shareWindowNoUserInfoAfterShare = true;
                            }
                            break;
                        case "shareWindowNoOpenInEmail":
                            if (custItem.value == "true")
                            {
                                window.shareWindowNoOpenInEmail = true;
                            }
                            break;
                        case "shareWindowEnableUsernameLookup":
                            if (custItem.value == "true")
                            {
                                window.shareWindowEnableUsernameLookup = true;
                            }
                            break;
                        case "shareWindowNoOpenInNewTab":
                            if (custItem.value == "true")
                            {
                                window.noOpenInNewTabManageShares = true;
                            }
                            break;
                        case "shareWindowDisableDirectLinkForFile":
                                window.shareWindowDisableDirectLinkForFile = custItem.value == "true";
                            break;
                        case "shareWindowFlagDirectLinkForFile":
                            window.shareWindowFlagDirectLinkForFile = custItem.value == "true";
                            break;
						case "shareAdvanced":
							//Allow/dis-allow advanced sharing option
							$(document).data("shareAdvanced", custItem.value);
							break;
						case "shareAllowUploads":
							//Allow/dis-allow uploads while sharing
							$(document).data("shareAllowUploads", custItem.value);
							break;
						case "disableThumbnailHover":
							//Enable/disable thumbnail hover info popup setting
							$(document).data("disableThumbnailHover", custItem.value);
							break;
                        case "defaultThumbnailSize":
                            //Default thumbs size (1 to 30)
                            var size = parseInt(custItem.value);
                            if(size && size != NaN)
                            {
                                if(size>30)size = 30;
                                if(size<0)size = 0;
                                window.defaultThumbnailSize = size;
                                if(typeof window.defaultThumbnailSize != "undefined" && typeof window.zoomSlider != "undefined")
                                {
                                    window.zoomSlider.slider("value", window.defaultThumbnailSize);
                                }
                            }
                            break;
						case "disableTreeviewHover":
							//Enable/disable treeview item hover info popup setting
							$(document).data("disableTreeviewHover", custItem.value);
							break;
                        case "disableUploadBarAnimation":
                            //Disable animation of upload bar when showing
                            if (custItem.value == "true") window.disableUploadBarAttentionAnimation = true;
                            break;
                        case "upload_hideUploadBarAfterUpload":
                            //Hide upload window after upload finishes
                            if (custItem.value == "true") window.hideUploadBarAfterUpload = true;
                            break;
						case "autoAppletFlag":
							//Load applet automatically when page loads flag
							if (!$.cookie(o.CookieAutoAppletFlag)) window.autoAppletFlagSet(custItem.value);
							if (custItem.value == "true") $("#autoAppletFlag").attr("checked", "checked");
							break;
                        case "autoUploadFlag":
                            //Load applet automatically when page loads flag
                            if (custItem.value == "true")
                                window.autoUploadFlagSet(custItem.value);
                            else
                                window.autoUploadFlagSet();
                            break;
                        case "notAllowedExtensionsToUpload":
                            if (custItem.value && custItem.value.length>0)
                            {
                                var exts = custItem.value.toLowerCase().split(",");
                                exts.clean("");
                                window.notAllowedExtensionsToUpload = exts;
                            }
                            break;
                        case "onlyAllowedExtensionsToUpload":
                            if (custItem.value && custItem.value.length>0)
                            {
                                var exts = custItem.value.toLowerCase().split(",");
                                exts.clean("");
                                window.onlyAllowedExtensionsToUpload = exts;
                            }
                            break;
                        case "compressionInApplet":
                            //admin preference to use compression in applet or not.
                            window.compressionInApplet = custItem.value;
                            break;
						case "showResume":
							//Show an option of resume in browser file upload window flag
							if (custItem.value == "false") {
								$("#browserFileUpload").find("label[for='chkUploadResume']").hide();
							} else {
								$("#browserFileUpload").find("label[for='chkUploadResume']").show();
							}
							break;
						case "pathBackgroundColor":
							// Path/Breadcrumbs background color
							$.cssRule({
								"#crumbs": [
									["background-color", custItem.value]
									]
							});
							break;
						case "pathTextColor":
							// Path/Breadcrumbs font color
							$.cssRule({
								"#crumbs li,#crumbs li a, #crumbs li a:visited": [
									["color", custItem.value]
									]
							});
							break;
						case "pathTextSize":
							// Path/Breadcrumbs text size
							$.cssRule({
								"#crumbs": [
									["font-size", custItem.value]
									]
							});
							break;
						case "quotaTextColor":
							// Quota text color
							$.cssRule({
								".quotaText": [
									["color", custItem.value]
									]
							});
							break;
						case "quotaTextSize":
							// Quota text size
							$.cssRule({
								".quotaText": [
									["font-size", custItem.value]
									]
							});
							break;
						case "quotaTextStyle":
							// Quota text style
							if (custItem.value.indexOf("bold") >= 0) {
								$.cssRule({
									".quotaText": [
										["font-weight", custItem.value]
										]
								});
							} else {
								$.cssRule({
									".quotaText": [
										["font-style", custItem.value]
										]
								});
							}
							break;
						case "quotaTextAlign":
							// Quota text allignment on screen
							$.cssRule({
								".quotaText": [
									["text-align", custItem.value]
									]
							});
							break;
						case "quotaBackgroundColor":
							// Quota text background color
							$.cssRule({
								".quotaText": [
									["background-color", custItem.value]
									]
							});
							break;
						case "commentsTextColor":
							// Comments text color
							$.cssRule({
								".comments": [
									["color", custItem.value]
									]
							});
							break;
						case "commentsTextSize":
							// Comments text size
							$.cssRule({
								".comments": [
									["font-size", custItem.value]
									]
							});
							break;
						case "commentsTextStyle":
							// Comments text style
							if (custItem.value.indexOf("bold") >= 0) {
								$.cssRule({
									".comments": [
										["font-weight", custItem.value]
										]
								});
							} else {
								$.cssRule({
									".comments": [
										["font-style", custItem.value]
										]
								});
							}
							break;
						case "commentsTextAlign":
							// Comments text allignment on screen
							$.cssRule({
								".comments": [
									["text-align", custItem.value]
									]
							});
							break;
						case "commentsBackgroundColor":
							// Comments background color
							$.cssRule({
								".comments": [
									["background-color", custItem.value]
									]
							});
							break;
						case "OPEN_NEW_WINDOW_EXTENSIONS":
							// Extensions to open in new window and void forced download
							var exts = custItem.value.split(",");
							if (exts && exts.length > 0) {
								var trimmed = [];
								$.each(exts, function(index, item){
									trimmed.push($.trim(this));
								});
								$(document).data("OPEN_NEW_WINDOW_EXTENSIONS", trimmed);
							} else {
								$(document).removeData("OPEN_NEW_WINDOW_EXTENSIONS");
							}
							break;
                        case "promptZipNameWhileDownloading" :
                            if (custItem.value == "true")
                            {
                                window.promptZipNameWhileDownloading = true;
                            }
                            break;
						case "OPEN_PREVIEW_EXTENSIONS":
							// Extensions to open preview window and void forced download
							var exts = custItem.value.split(",");
							if (exts && exts.length > 0) {
								var trimmed = [];
								$.each(exts, function(index, item){
									trimmed.push($.trim(this));
								});
								$(document).data("OPEN_PREVIEW_EXTENSIONS", trimmed);
							} else {
								$(document).removeData("OPEN_PREVIEW_EXTENSIONS");
							}
							break;
                        case "TooltipExifInfoKeys":
                            if (custItem.value && custItem.value.length > 0)
                                window.TooltipExifInfoKeys = custItem.value;
                            break;
                        case "EditeableExifInfoKeys":
                            if (custItem.value && custItem.value.length > 0)
                                window.EditeableExifInfoKeys = custItem.value;
                            break;
						case "genericIconTree":
							//Generic icon to use in tree, no preview icon
							if (custItem.value && custItem.value.length > 0 && custItem.value == "true") {
								$(document).data("genericIconTree", true);
							}
							break;
						case "genericIconThumbnail":
							//Generic icon to use in thumbnails, no preview icon
							if (custItem.value && custItem.value.length > 0 && custItem.value == "true") {
								$(document).data("genericIconThumbnail", true);
							}
							break;
						case "maxAllowedDownloadSize":
							//Maximum size allowed to download
							if (custItem.value && custItem.value.length>0) {
								$(document).data("maxAllowedDownloadSize", custItem.value);
							}
							break;
						case "hideAdvancedUploader":
							//Hide advanced uploader
							if (custItem.value == "true")
							{
								$("#browseTypeSelector").hide();
							}
							break;
                        case "defaultAdvancedUploader":
                            //make advanced uploader default
                            if (custItem.value == "true")
                            {
                                setTimeout(function(){
                                    $("#browseTypeSelector").removeClass("advanced").addClass("normal").trigger("click").attr("title", locale.fileupload.SwitchToNormalUpload).removeData('thisInfo').unbind('.cluetip');
                                    vtip($("#browseTypeSelector"));
                                }, 500);
                            }
                            break;
                        case "hideShareMethod":
                            $.cssRule({
                                ".shareMethodRow": [
                                    ["display", "none !important"]
                                    ]
                            });
                            break;
                        case "hideInternalShareMethod":
                            $.cssRule({
                                ".shareInternalOption": [
                                    ["display", "none !important"]
                                    ]
                            });
                            break;
                        case "hideExternalShareMethod":
                            $.cssRule({
                                ".shareExternalOption": [
                                    ["display", "none !important"]
                                    ]
                            });
                            break;
                        case "hideShareType":
                            $.cssRule({
                                "#shareTypeRow": [
                                    ["display", "none !important"]
                                    ]
                            });
                            break;
                        case "hideShareSendEmail":
                            $.cssRule({
                                ".sendEmail": [
                                    ["display", "none !important"]
                                    ]
                            });
                            break;
                        case "hideShareExpiresRow":
                            $.cssRule({
                                "#shareExpirationRow": [
                                    ["display", "none !important"]
                                    ]
                            });
                            break;
                        case "hideShareFromRow":
                            $.cssRule({
                                ".emailFrom": [
                                    ["display", "none !important"]
                                    ]
                            });
                            break;
                        case "hideShareToRow":
                            $.cssRule({
                                ".emailTo": [
                                    ["display", "none !important"]
                                    ]
                            });
                            break;
                        case "hideShareCCRow":
                            $.cssRule({
                                ".emailCc": [
                                    ["display", "none !important"]
                                    ]
                            });
                            break;
                        case "hideShareBCCRow":
                            $.cssRule({
                                ".emailBcc": [
                                    ["display", "none !important"]
                                    ]
                            });
                            break;
                        case "hideShareSubjectRow":
                            $.cssRule({
                                ".emailSubject": [
                                    ["display", "none !important"]
                                    ]
                            });
                            break;
                        case "readonlyShareSubject":
                            window.shareWindoeEmailSubjectReadonly = custItem.value == "true";
                            break;
                        case "hideShareBodyRow":
                            $.cssRule({
                                ".emailBody": [
                                    ["display", "none !important"]
                                    ]
                            });
                            break;
                        case "readonlyShareBody":
                            window.shareWindoeEmailBodyReadonly = custItem.value == "true";
                            break;
                        case "hideAdvancedOption":
                            $.cssRule({
                                "#shareAdvancedHolder": [
                                    ["display", "none !important"]
                                    ]
                            });
                            break;
                        case "hideAttachThumbnailOption":
                            $.cssRule({
                                "#shareAttachHolder": [
                                    ["display", "none !important"]
                                    ]
                            });
                            break;
                        case "hideFullAccessOption":
                            $.cssRule({
                                "#shareFullAccessHolder": [
                                    ["display", "none !important"]
                                    ]
                            });
                            break;
                        /*Upload window customizations*/
                        case "upload_UploadBarBorderColor":
                            $.cssRule({
                                "#fileQueueInfo": [
                                    ["border-color", custItem.value]
                                    ]
                            });
                            break;
                        case "upload_UploadBarBGColor":
                            $.cssRule({
                                "#fileQueueInfo": [
                                    ["background", custItem.value]
                                    ]
                            });
                            break;
                        case "upload_UploadBarTextColor":
                            $.cssRule({
                                "#fileQueueInfo": [
                                    ["color", custItem.value]
                                    ]
                            });
                            break;
                        case "upload_UploadBarDragHoverBGColor":
                            $.cssRule({
                                ".dropzone.hover": [
                                    ["background", custItem.value]
                                    ]
                            });
                            break;
                        case "upload_UploadBarDragHoverTextColor":
                            $.cssRule({
                                ".dropzone.hover": [
                                    ["color", custItem.value]
                                    ]
                            });
                            break;
                        case "upload_fileWindowAsDialog":
                            if(custItem.value == "true")
                            {
                                window.fileWindowAsDialog = true;
                            }
                            break;
                        case "upload_UploadQueueHeaderBGColor":
                            $.cssRule({
                                ".fileListHeader, div.uploadFormHeader": [
                                    ["background", custItem.value],
                                    ["background-color", custItem.value]
                                    ]
                            });
                            break;
                         case "upload_UploadQueueHeaderBorderColor":
                            $.cssRule({
                                ".fileListHeader, div.uploadFormHeader": [
                                    ["border-color", custItem.value]
                                    ]
                            });
                            break;
                        case "upload_UploadQueueHeaderTextColor":
                            $.cssRule({
                                ".fileListHeader, div.uploadFormHeader": [
                                    ["color", custItem.value]
                                    ]
                            });
                            break;
                        case "upload_UploadQueueBGColor":
                            $.cssRule({
                                "#fileRepo,#uploadInfoForm, .ui-dialog .ui-dialog-buttonpane": [
                                    ["background", custItem.value],
                                    ["background-color", custItem.value]
                                    ]
                            });
                            break;
                        case "upload_UploadQueueTextColor":
                            $.cssRule({
                                "#fileRepo, #uploadInfoForm": [
                                    ["color", custItem.value]
                                    ]
                            });
                            $.cssRule({
                                "#fileRepo a, #fileRepo .ui-widget-content": [
                                    ["color", custItem.value + " !important"]
                                    ]
                            });
                            break;
                        case "upload_UploadQueueItemBGColor":
                            $.cssRule({
                                "#fileRepo .template-upload": [
                                    ["background", custItem.value]
                                    ]
                            });
                            break;
                        case "upload_UploadQueueItemTextColor":
                            $.cssRule({
                                "#fileRepo .template-upload": [
                                    ["color", custItem.value]
                                    ]
                            });
                            $.cssRule({
                                "#fileRepo .template-upload a, #fileRepo .template-upload.ui-widget-content": [
                                    ["color", custItem.value + " !important"]
                                    ]
                            });
                            break;
                        case "upload_UploadProgressbarBGColor":
                            $.cssRule({
                                "#fileRepo .template-upload": [
                                    ["background", custItem.value]
                                    ]
                            });
                            break;
                        case "upload_UploadProgressbarTextColor":
                            $.cssRule({
                                "#globalProgressBar": [
                                    ["color", custItem.value]
                                    ]
                            });
                            $.cssRule({
                                "#globalProgressBar a": [
                                    ["color", custItem.value + " !important"]
                                    ]
                            });
                            break;
                        case "slideshow_BackgroundColor":
                            if($(document).data("slideShowOnly"))
                            {
                                $.cssRule({
                                    "#slideshowPage, #slideshowPage #container, #slideshowPage #fileQueueInfo, div.slideshow a.advance-link, div.caption-container, span.image-caption, div.photo-index, div.navigation-container, div.navigation, ul.thumbs, div.pagination span.current, .image-wrapper": [
                                        ["background", custItem.value]
                                        ]
                                });
                            }
                            window.slideshowBG = custItem.value;
                            break;
                        case "slideshow_TextColor":
                            if($(document).data("slideShowOnly"))
                            {
                               $.cssRule({
                                    "#slideshowPage, #slideshowPage #container, #slideshowPage #fileQueueInfo, div.slideshow a.advance-link, div.caption-container, span.image-caption, div.photo-index, div.navigation-container, div.navigation, ul.thumbs, div.pagination span.current": [
                                        ["color", custItem.value]
                                        ]
                                });
                               if(!window.slideshowAnchorCSSSet)
                               {
                                    $.cssRule({
                                        "#slideshowPage a, #itemControls": [
                                            ["color", custItem.value]
                                            ]
                                    });
                                }
                            }
                            break;
                        case "slideshow_AnchorColor":
                            if($(document).data("slideShowOnly"))
                            {
                                $.cssRule({
                                    "#slideshowPage a, #itemControls, #SSPage .play,#SSPage .pause,#SSPage .prev,#SSPage .next, #footerss a": [
                                        ["color", custItem.value]
                                        ]
                                });
                                window.slideshowAnchorCSSSet = true;
                            }
                            break;
                        case "slideshow_AutoStartInXSeconds":
                            if($(document).data("slideShowOnly"))
                            {
                                var slideshowAutoStartIn = parseInt(custItem.value);
                                if(slideshowAutoStartIn && slideshowAutoStartIn!= NaN)
                                {
                                    if(slideshowAutoStartIn<=0)slideshowAutoStartIn=1;
                                    setTimeout(function(){
                                        $("#controls").find("a.play").trigger("click");
                                    }, slideshowAutoStartIn * 1000);
                                }
                            }
                            break;
                        /*Basket items*/
                        case "basket_HeaderBGColor":
                            $.cssRule({
                                ".downloadBasket .ui-widget-header": [
                                    ["background", custItem.value],
                                    ["background-color", custItem.value]
                                    ]
                            });
                            break;
                         case "basket_HeaderBorderColor":
                            $.cssRule({
                                ".downloadBasket .ui-widget-header": [
                                    ["border-color", custItem.value]
                                    ]
                            });
                            break;
                        case "basket_HeaderTextColor":
                            $.cssRule({
                                ".downloadBasket .ui-widget-header": [
                                    ["color", custItem.value]
                                    ]
                            });
                            break;
                        case "basket_BGColor":
                            $.cssRule({
                                ".downloadBasket,.downloadBasket #filesBasket, .downloadBasket .ui-dialog .ui-dialog-buttonpane": [
                                    ["background", custItem.value],
                                    ["background-color", custItem.value]
                                    ]
                            });
                            break;
                        case "basket_TextColor":
                            $.cssRule({
                                ".downloadBasket, #filesBasket": [
                                    ["color", custItem.value]
                                    ]
                            });
                            $.cssRule({
                                ".downloadBasket a, .downloadBasket .ui-widget-content": [
                                    ["color", custItem.value + " !important"]
                                    ]
                            });
                            break;
                        case "basket_TVHeaderBGColor":
                            $.cssRule({
                                ".downloadBasket thead td": [
                                    ["background", custItem.value]
                                    ]
                            });
                            break;
                        case "basket_TVHeaderTextColor":
                            $.cssRule({
                                ".downloadBasket thead td": [
                                    ["color", custItem.value + " !important"]
                                    ]
                            });
                            break;
                        case "basket_TVBGColor":
                            $.cssRule({
                                ".downloadBasket #basketFilesContainer tbody tr": [
                                    ["background", custItem.value],
                                    ["background-color", custItem.value]
                                    ]
                            });
                            break;
                         case "basket_TVTextColor":
                            $.cssRule({
                                ".downloadBasket #basketFilesContainer tbody td, .downloadBasket #basketFilesContainer tbody td a, a.imgLink": [
                                    ["color", custItem.value + " !important"]
                                    ]
                            });
                            break;
                        case "basket_TVHoverBGColor":
                            $.cssRule({
                                ".downloadBasket #basketFilesContainer .rowHover": [
                                    ["background", custItem.value + " !important"],
                                    ["background-color", custItem.value + " !important"]
                                    ]
                            });
                            break;
                        case "basket_TVHoverTextColor":
                            $.cssRule({
                                ".downloadBasket #basketFilesContainer .rowHover td, .downloadBasket #basketFilesContainer .rowHover td a, a.imgLink": [
                                    ["color", custItem.value + " !important"]
                                    ]
                            });
                            break;
                        case "basket_HideCheckbox":
                            if(custItem.value == "true")
                            {
                                $.cssRule({
                                    ".downloadBasket #basketFilesContainer .thSelect, .downloadBasket #basketFilesContainer .columnSelect": [
                                        ["display", "none !important"]
                                        ]
                                });
                            }
                            break;
                        case "basket_DefaultView":
                            if(custItem.value == "treeview")
                            {
                                $("#viewSelectorPanelBasket").find("a.treeViewLink").trigger("click");
                            }
                            else
                            {
                                $("#viewSelectorPanelBasket").find("a.thumbnailViewLink").trigger("click");
                            }
                            break;
                        case "hideViewSelector":
                            if(custItem.value == "true")
                            {
                                $.cssRule({
                                    "#viewSelectorPanel": [
                                        ["display", "none !important"]
                                        ]
                                });
                            }
                            break;
                        case "listDefaultView":
                            if(!window.customListDefaultView)
                            {
                                if(custItem.value == "treeview")
                                {
                                    window.customListDefaultView = "tree";
                                    changeView("tree");
                                    $(".treeViewLink", "#viewSelectorPanel").animate({
                                        opacity: 0.3
                                    }, 500);
                                    $(".thumbnailViewLink", "#viewSelectorPanel").animate({
                                        opacity: 1
                                    }, 500);
                                }
                                else
                                {
                                    window.customListDefaultView = "thumbs";
                                     $(".thumbnailViewLink", "#viewSelectorPanel").animate({
                                        opacity: 0.3
                                    }, 500);

                                    $(".treeViewLink", "#viewSelectorPanel").animate({
                                        opacity: 1
                                    }, 500);
                                    changeView("Thumbnail");
                                }
                            }
                            break;
                        case "basket_NoViewChange":
                            if(custItem.value == "true")
                            {
                                $.cssRule({
                                    "#viewSelectorPanelBasket": [
                                        ["display", "none !important"]
                                        ]
                                });
                            }
                            break;
                        case "basket_Maximized":
                            if(custItem.value == "true")
                            {
                                window.basketKeepMaximized = true;
                            }
                            break;
                        case "basket_HideFilter":
                            if(custItem.value == "true")
                            {
                                $.cssRule({
                                    "#filterPanelBasket": [
                                        ["display", "none !important"]
                                        ]
                                });
                            }
                            break;
                        case "basket_HideDownload":
                            if(custItem.value == "true")
                            {
                                $.cssRule({
                                    "#BasketDownloadLinkText": [
                                        ["display", "none !important"]
                                        ]
                                });
                            }
                            break;
                        case "basket_HideShare":
                            if(custItem.value == "true")
                            {
                                $.cssRule({
                                    "#BasketShareItemsLinkText": [
                                        ["display", "none !important"]
                                        ]
                                });
                            }
                            break;
                        case "basket_HideDownloadAdvanced":
                            if(custItem.value == "true")
                            {
                                $.cssRule({
                                    "#BasketDownloadAdvancedLinkText": [
                                        ["display", "none !important"]
                                        ]
                                });
                            }
                            break;
                        case "basket_NoContextMenu":
                            if(custItem.value == "true")
                            {
                                window.disableContextMenuOnBasket = true;
                            }
                            break;
                        case "basket_ThumbnailsBorderColor":
                            $.cssRule({
                                ".fileBoxBasket .imgBox": [
                                    ["border-color", custItem.value],
                                    ["-moz-box-shadow", "none"],
                                    ["-webkit-box-shadow", "none"],
                                    ["box-shadow", "none"]
                                ]
                            });
                            break;
                        case "basket_ThumbnailsHoverBorderColor":
                            $.cssRule({
                                ".fileBoxBasket:hover": [
                                    ["border-color", custItem.value]
                                ]
                            });
                            break;
                        case "thumbnailsImageBoxBorderColor":
                            $.cssRule({
                                ".fileBox .imgBox": [
                                    ["border-color", custItem.value],
                                    ["-moz-box-shadow", "none"],
                                    ["-webkit-box-shadow", "none"],
                                    ["box-shadow", "none"]
                                ]
                            });
                            break;
                        case "thumbnailsBorderColor":
                            $.cssRule({
                                ".fileBox": [
                                    ["border-color", custItem.value],
                                    ["-moz-box-shadow", "none"],
                                    ["-webkit-box-shadow", "none"],
                                    ["box-shadow", "none"]
                                ]
                            });
                            break;
                        case "thumbnailsHoverBorderColor":
                            $.cssRule({
                                ".fileBox:hover": [
                                    ["border-color", custItem.value]
                                ]
                            });
                            break;
                        case "UPLOAD_THREADS":
                                window.UPLOAD_THREADS = parseInt(custItem.value);
                                if(!window.UPLOAD_THREADS || window.UPLOAD_THREADS == NaN)
                                    window.UPLOAD_THREADS = 1;
                            break;
                        case "DOWNLOAD_THREADS":
                                window.DOWNLOAD_THREADS = parseInt(custItem.value);
                                if(!window.DOWNLOAD_THREADS || window.DOWNLOAD_THREADS == NaN)
                                    window.DOWNLOAD_THREADS = 1;
                            break;
                        case "pagination_Color":
                            $.cssRule({
                                ".pagination a": [
                                    ["color", custItem.value]
                                    ]
                            });
                            break;
                        case "pagination_BGColor":
                            $.cssRule({
                                ".pagination a": [
                                    ["background-color", custItem.value]
                                    ]
                            });
                            break;
                        case "pagination_BorderColor":
                            $.cssRule({
                                ".pagination a": [
                                    ["border-color", custItem.value]
                                    ]
                            });
                            break;
                        case "pagination_ActiveColor":
                            $.cssRule({
                                ".pagination .current": [
                                    ["color", custItem.value]
                                    ]
                            });
                            break;
                        case "pagination_ActiveBGColor":
                            $.cssRule({
                                ".pagination .current": [
                                    ["background-color", custItem.value]
                                    ]
                            });
                            break;
                        case "pagination_ActiveBorderColor":
                            $.cssRule({
                                ".pagination .current": [
                                    ["border-color", custItem.value]
                                    ]
                            });
                            break;
                          case "pagination_DisabledColor":
                            $.cssRule({
                                ".pagination .prev.disable, .pagination .next.disable": [
                                    ["color", custItem.value]
                                    ]
                            });
                            break;
                        case "pagination_DisabledBGColor":
                            $.cssRule({
                                ".pagination .prev.disable, .pagination .next.disable": [
                                    ["background-color", custItem.value]
                                    ]
                            });
                            break;
                        case "pagination_DisabledBorderColor":
                            $.cssRule({
                                ".pagination .prev.disable, .pagination .next.disable": [
                                    ["border-color", custItem.value]
                                    ]
                            });
                            break;
                        case "pagination_HoverColor":
                            $.cssRule({
                                ".pagination a:hover, .pagination span:hover": [
                                    ["color", custItem.value]
                                    ]
                            });
                            break;
                        case "pagination_HoverBGColor":
                            $.cssRule({
                                ".pagination a:hover, .pagination span:hover": [
                                    ["background-color", custItem.value]
                                    ]
                            });
                            break;
                        case "pagination_HoverBorderColor":
                            $.cssRule({
                                ".pagination a:hover, .pagination span:hover": [
                                    ["border-color", custItem.value]
                                    ]
                            });
                            break;
                        case "maskedEmptyFolder":
                            if(custItem.value == "true")
                            {
                                window.maskedEmptyFolder = true;
                            }
                            break;
                        case "autoNavigateToFolderOnCreation":
                            if(custItem.value == "true")
                            {
                                $("#chkNavigateAfterMkdir").attr("checked", "checked");
                            }
                            break;
                        case "cutCopyOnlyFiles":
                            if(custItem.value == "true")
                            {
                                window.cutCopyOnlyFiles = true;
                            }
                            break;
                        case "uploadFormAskAgainChecked":
                            window.uploadFormAskAgainChecked = custItem.value == "true";
                            break;
                        case "uploadFormAskAgainHideAndChecked":
                            window.uploadFormAskAgainHideAndChecked = custItem.value == "true";
                            break;
                        case "uploadFormAskAgainHideAndUnchecked":
                            window.uploadFormAskAgainHideAndUnchecked = custItem.value == "true";
                            break;
                        case "useHTML5PlayerWhenAvailable":
                            window.useHTML5PlayerWhenAvailable = custItem.value == "true";
                            break;
						default:
							break;
						}
					}
					var destinationPath = hashListener.getHash().toString().replace("#", "");
					if (destinationPath.indexOf("/IMPULSEUpload/") > 0) //Upload only
					{
						makeItUploadOnly();
					}
				}

				//Get popup color
				function getPopupColor(bg, header, headertext, slideshow) {
					if (bg) {
						return $(document).data("popupBackgroundColor") || "#FFF";
					}
                    else if (header) {
                        return $(document).data("popupHeaderBackgroundColor") || "#F1EEEE";
                    }
                    else if (headertext) {
                        return $(document).data("popupHeaderTextColor") || "#000";
                    }
                    else if(slideshow)
                    {
                        if(window.slideshowBG)
                            return window.slideshowBG;
                        else
                            return $(document).data("popupBackgroundColor") || "#000";
                    } else {
						return $(document).data("popupBorderColor") || "#CCC";
					}
				}

				window.getPopupColorExternal = function(bg, header, headertext)
				{
					return getPopupColor(bg, header, headertext);
				}

				//Apply share popup customizations
				function applyShareCustomizations() {
					var customizations = $(document).data("customizations");
                    if(window.shareWindoeEmailBodyReadonly)
                        $("textarea#emailBody", "#shareOptionDiv").attr("readonly", "readonly");
                    if(window.shareWindoeEmailSubjectReadonly)
                        $("#emailSubject", "#shareOptionDiv").attr("readonly", "readonly");
					if (customizations)
                    {
    					for (var item in customizations) {
    						var custItem = customizations[item];
    						switch (custItem.key) {
    						case "EXPIREDAYS":
    							$("#txtdays", "#shareOptionDiv").val(custItem.value);
                                window.ShareItemExpiresInDays = parseInt(custItem.value);
                                if (window.ShareItemExpiresInDays == NaN) window.ShareItemExpiresInDays = 30;
    							break;
                            case "SENDEMAILDEFAULT":
                                if(custItem.value == "true")
                                    $("#sendEmail").attr("checked","checked");
                                else
                                    $("#sendEmail").removeAttr("checked");
                                break;
                            case "SHAREMETHOD":
                                if(custItem.value && custItem.value.toLowerCase() == "internal")
                                    $("#shareUsername", "#shareOptionDiv").attr("checked","checked");
                                else
                                    $("#externalUser", "#shareOptionDiv").attr("checked","checked");
                                break;
    						case "EMAILFROM":
    							$("#emailFrom").val(custItem.value);
    							break;
    						case "EMAILTO":
    							$("#emailTo").val(custItem.value);
    							break;
    						case "EMAILCC":
    							$("#emailCc").val(custItem.value);
    							break;
    						case "EMAILBCC":
    							$("#emailBcc").val(custItem.value);
    							break;
    						case "EMAILSUBJECT":
    							$("#emailSubject").val(custItem.value);
    							break;
    						case "EMAILBODY":
    							custItem.value = custItem.value.replace(/\\r/g, '\r');
    							custItem.value = custItem.value.replace(/\\n/g, '\n');
    							var emailVal = custItem.value;
    							window.shareEmailBody = crushFTPTools.decodeXML(emailVal);
    							$("textarea#emailBody", "#shareOptionDiv").val(emailVal);
    							break;
    						default:
    							break;
    						}
    					}
                        if(window.shareWindowEnableUsernameLookup == true)
                        {
                            setTimeout(function(){
                                var formName = "share_form";
                                var elemName = "shareUsernames"
                                var elem = $("#shareUsernames");
                                if(!$(elem).data("autoCompleteAdded"))
                                {
                                    $(elem).tokenInput("/WebInterface/function/?command=lookup_form_field&form_name="+formName+"&form_element_name=" + elemName, {
                                        theme : "facebook",
                                        preventDuplicates : true,
                                        onResult: function (results, val) {
                                            if(results && results.length==0 && val)
                                            {
                                                results = [{"id":val,"name":val}];
                                            }
                                            return results;
                                        }
                                    });
                                    $(elem).data("autoCompleteAdded", true);
                                }
                            }, 500);
                        }
                        if(typeof window.shareWindowFlagDirectLinkForFile != "undefined")
                        {
                            var dierctLink = $("#frmShareWindow").find(".directLink").hide();
                            if(window.shareWindowFlagDirectLinkForFile)
                                dierctLink.find("input").removeAttr("checked");
                            else
                                dierctLink.find("input").attr("checked", "checked");
                        }
                    }
                    if(!window.quickShareEmailBody)
                    {
                        window.quickShareEmailBody = crushFTPTools.decodeXML($("textarea#emailBody", "#shareOptionDiv").val());
                    }
				}

				//Switch to slideshow only mode
				function makeItSlideShowOnly() {
					$("#mainContent").hide();
					$(document).data("slideShowOnly", true);
					$("div.mainNavigation").remove();
					$("#headerContent").prepend("<a id=\"logoutLinkTopCorner\" href=\"javascript:doLogout();\">"+getLocalizationKey("LogoutButtonText")+"</a>");
					window.slideshowOnly = true;
					doSlideshow(true);
				}

				//Switch to upload only mode
				function makeItUploadOnly() {
                    if(!$.CrushFTP.DNDAdded)
                    {
                        $.CrushFTP.attachDND(o);
                        $.CrushFTP.DNDAdded = true;
                    }
                    setTimeout(function() {
					   browserUploader();
                    }, 100);
					var $elem = $("div#fileQueueInfo, div#dropItemsPanel, div#javaAppletDiv");
					$("#mainContent").hide().before($elem);//.after("<span class='clear'></span>");
					$("#hideUploadPanel").hide();
					$("#mainContent").before($("div.mainNavigation"));
					$("div.mainNavigation").remove();
					$("#headerContent").prepend("<a id=\"logoutLinkTopCorner\" href=\"javascript:doLogout();\">"+getLocalizationKey("LogoutButtonText")+"</a>");
                    $("#header").css("margin-top", "15px");
                    var fileRepo = $("#fileRepo");
                    fileRepo.draggable("destroy");
                    fileRepo.css("position", "relative");
                    fileRepo.find(".fileListHeader").css("cursor","auto");
                    $("#viewFileQueue").remove();
                    fileRepo.find("#toggleFileList").remove();
                    fileRepo.css("width","99%");
                    fileRepo.find("ul.files").css({
                        "max-height" : "600px",
                        "overflow-y" : "",
                        "width" : "auto"
                    });
                    $.cssRule({
                        ".template-upload .name": [
                            ["width", "500px"]
                            ]
                    });
					$(document).data("uploadOnly", true);
				}

                function showDirListingFile(callback)
                {
                    var loadingIndicator = $("#loadingIndicator");
                    loadingIndicator.dialog('open');
                    var path = document.location.hash;
                    if (path == "") path = "/";
                    if (path.indexOf("#") == 0) path = path.substring(1);
                    $("#htmlListingFile").empty().show().load(path + window.listingHTMLPage, function(response, status, xhr){
                        if (status == "error") {
                            window.listingPageShown = false;
                            if(callback)
                                callback();
                        }
                        else
                        {
                            window.listingPageShown = true;
                            $("#mainNavigation").hide();
                            $("#filesListing, #fileQueueInfo").hide();
                            $(".layoutActionElement").hide();
                            loadingIndicator.dialog('close');
                            $(".mainProcessIndicator").hide();
                            bindBreadcrumbs();
                        }
                    });
                }

				//Show slideshow popup, if slideshow only cover whole page with slideshow
				window.doSlideshow = function (_slideshowOnly, _popup) {
					var path = document.location.hash;
					if (path == "") path = "/";
					if (path.indexOf("#") == 0) path = path.substring(1);
					if ($(document).data("slideShowOnly")) {
						$("#mainContent").before($('div.slideshow'));
						$('div.slideshow').before($("div.mainNavigation"));
					}
					var h = window.innerHeight ? window.innerHeight : $(window).height();
					h = h * 0.92;
					var destinationPath = "#" + path;
					$('div.slideshow').empty().append('<iframe frameborder="0" scrolling="auto" style="width: 100%; height:' + h + 'px;background-color: #000000;" name="cftp_iframeSS" id="cftp_iframeSS" src="/WebInterface/jQuery/slideshowView.html' + destinationPath + '" hspace="0" allowtransparency="false"></iframe>');
					$(window).bind("resize", function () {
						//When window resizes control and slideshow should resize its size
						resetSlideShowDimensions();
					});
				}
                //Hide Sync Popup
                window.hideSyncPopup = function()
                {
                    $("#manageSyncPanel").dialog("close");
                }

                //Sync loaded
                window.resizeSyncPopup = function()
                {
                    if($("#manageSyncPanel").hasClass("resized"))return;
                    var manageSyncPanel = $("#manageSyncPanel").addClass("resized").dialog("open").dialog("widget").animate({
                        title : "Manage Syncs",
                        width: '1000px',
                        height: '600px'
                    }, {
                            duration: 500,
                            step: function() {
                                jQuery("#manageSyncPanel").dialog('option', 'position', 'center');
                            }
                    });
                    manageSyncPanel.dialog( "option", "position", manageSyncPanel.dialog( "option", "position" ) );
                    $("#manageSyncPanel").css("height","auto").find("iframe").attr("style", "width: 100%; height:570px;background-color: #fff;margin:0px;padding:0px;");
                }

                window.resetSyncPopupTitle = function()
                {
                    var _title = $("#manageSyncPanel").parent().find(".ui-dialog-titlebar").css("position","absolute").css("width", "100%");
                    setTimeout(function(){
                        _title.css("position","relative").css("width", "auto");
                    }, 100);
                }
                //Show manage sync popup
                window.popupManageSync = function (_slideshowOnly, _popup) {
                    var h = window.innerHeight ? window.innerHeight : $(window).height();
                    h = h * 0.92;
                    var manageSyncPanel = $("#manageSyncPanel").removeClass("resized").dialog({
                        autoOpen: false,
                        closeOnEscape: false,
                        title : "Manage Syncs",
                        draggable: true,
                        width: "500",
                        minHeight: 300,
                        height: 300,
                        modal: true,
                        buttons: {},
                        resizable: false,
                        position: "center",
                        open : function()
                        {
                            var closeButton = manageSyncPanel.parent().find(".ui-dialog-titlebar-close");
                            if(closeButton.parent().find("a.openInNewTab").length==0)
                            {
                                var _openLink = localizations.popupOpenInSeparateWindowText|| "Open in a separate window";
                                closeButton.after('<a title="'+_openLink+'" target="_blank" href="/WebInterface/sync/index.html" role="button" style="float: right;margin-right: 13px;margin-top: 0px;font-size: 12px;font-weight: normal;display: inline-block;width: auto;" class="openInNewTab ui-corner-all"><span style="float:left;" class="ui-icon ui-icon-newwin"></span>'+_openLink+'</a>');
                                var newTabLink = closeButton.parent().find("a.openInNewTab").click(function(){
                                    window.hideSyncPopup();
                                });
                            }
                        },
                        create: function(event, ui) {
                            $(event.target).parent().css('position', 'fixed');
                        },
                        resizeStop: function(event, ui) {
                            var position = [(Math.floor(ui.position.left) - $(window).scrollLeft()),
                                             (Math.floor(ui.position.top) - $(window).scrollTop())];
                            $(event.target).parent().css('position', 'fixed');
                            $(dlg).dialog('option','position',position);
                        }
                    });
                    manageSyncPanel.empty().append('<iframe frameborder="0" scrolling="auto" style="width: 100%;height:300px;background-color: #fff;margin:0px;padding:0px;" name="cftp_iframeManageSync" id="cftp_iframeManageSync" src="/WebInterface/sync/index.html?popup=true" hspace="0" allowtransparency="false"></iframe>');
                    manageSyncPanel.dialog("open");
                }

                window.popupManageShares = function()
                {
                    var h = window.innerHeight ? window.innerHeight : $(window).height();
                    h = h * 0.92;
                    var manageSharesPanel = $("#manageSharesPanel").removeClass("resized").dialog({
                        autoOpen: false,
                        closeOnEscape: false,
                        title : localizations.ManageShareWindowHeaderText,
                        draggable: true,
                        width: "80%",
                        maxHeight: h,
                        height : 650,
                        minWidth : 800,
                        modal: true,
                        buttons: {},
                        resizable: true,
                        position: "center",
                        open : function()
                        {
                            var closeButton = manageSharesPanel.parent().find(".ui-dialog-titlebar-close");
                            if(!window.noOpenInNewTabManageShares && closeButton.parent().find("a.openInNewTab").length==0)
                            {
                                var _openLink = localizations.popupOpenInSeparateWindowText|| "Open in a separate window";
                                closeButton.after('<a title="'+_openLink+'" target="_blank" href="/WebInterface/ManageShares/index.html" role="button" style="float: right;margin-right: 13px;margin-top: 0px;font-size: 12px;font-weight: normal;display: inline-block;width: auto;" class="openInNewTab ui-corner-all"><span style="float:left;" class="ui-icon ui-icon-newwin"></span>'+_openLink+'</a>');
                                var newTabLink = closeButton.parent().find("a.openInNewTab").click(function(){
                                    manageSharesPanel.dialog("close");
                                });
                            }

                            var closeButton = manageSharesPanel.parent().find(".ui-dialog-titlebar-close").show().unbind("hover");
                            if(closeButton.parent().find("a.fullScreen").length==0)
                            {
                                closeButton.after('<a title="Maximize" href="#" role="button" style="float: right;margin-right: 13px;margin-top: 0px;" class="fullScreen ui-corner-all"><span class="ui-icon ui-icon-arrow-4-diag">Fullscreen</span></a>');
                                var fullScreenLink = closeButton.parent().find("a.fullScreen").click(function(){
                                    var isFullS = manageSharesPanel.attr("maximized");
                                    if(!isFullS)
                                    {
                                        $(this).find("span").addClass("ui-icon-arrow-1-sw").removeClass("ui-icon-arrow-4-diag");
                                        $(this).attr("title", "Resize to original size");
                                        var h = window.innerHeight ? window.innerHeight : $(window).height();
                                        var w = $(window).width() - 10;
                                        h -= 5;
                                        manageSharesPanel.parent().css("position", "fixed");
                                        manageSharesPanel.dialog("widget").animate({
                                            width: w+'px',
                                            height:h+'px'
                                          }, {
                                          duration: 100,
                                          step: function() {
                                            manageSharesPanel.dialog('option', 'position', 'top');
                                          }
                                        });
                                        manageSharesPanel.dialog('option', 'resizable', false);
                                        manageSharesPanel.dialog('option', 'draggable', false);
                                        manageSharesPanel.height(h + "px");
                                        h -= 30;
                                        manageSharesPanel.find("iframe").height(h + "px");
                                        manageSharesPanel.find("iframe").width(w + "px");
                                        manageSharesPanel.attr("maximized", "true");
                                    }
                                    else
                                    {
                                        $(this).attr("title", "Maximize");
                                        $(this).find("span").addClass("ui-icon-arrow-4-diag").removeClass("ui-icon-arrow-1-sw");
                                        manageSharesPanel.parent().css("position", "absolute");
                                        manageSharesPanel.dialog("widget").animate({
                                            width: '80%',
                                            height:'650px'
                                          }, {
                                          duration: 100,
                                          step: function() {
                                            manageSharesPanel.dialog('option', 'position', 'center');
                                          }
                                        });
                                        manageSharesPanel.dialog('option', 'resizable', true);
                                        manageSharesPanel.dialog('option', 'draggable', true);
                                        manageSharesPanel.find("iframe").height("600px").width("100%");
                                        manageSharesPanel.removeAttr("maximized");
                                    }
                                    return false;
                                });
                            }
                            else
                            {
                                if(manageSharesPanel.attr("maximized"))
                                {
                                    manageSharesPanel.removeAttr("maximized");
                                }
                                else
                                {
                                    manageSharesPanel.attr("maximized", "true");
                                }
                                closeButton.parent().find("a.fullScreen").trigger("click");
                            }
                        },
                        create: function(event, ui) {
                            $(event.target).parent().css('position', 'fixed');
                        },
                        resizeStop: function(event, ui) {
                            manageSharesPanel.width("100%");
                            if(ui.size.height > 650)
                                manageSharesPanel.find("iframe").height(ui.size.height - 50);
                            else
                                manageSharesPanel.find("iframe").height(600);
                        }
                    });
                    manageSharesPanel.empty().append('<iframe frameborder="0" scrolling="auto" style="width: 100%;background-color: #fff;margin:0px;padding:0px;height:600px;" name="cftp_iframeManageShares" id="cftp_iframeManageShares" src="/WebInterface/ManageShares/index.html?popup=true" hspace="0" allowtransparency="false"></iframe>');
                    manageSharesPanel.dialog("open");
                }

                function rotateImage(imgControl, flag)
                {
                    if(!imgControl || imgControl.length==0)return;
                    var curAngle = imgControl.attr("curAngle") || 0;
                    curAngle = parseInt(curAngle);
                    var oldAngle = parseInt(curAngle);
                    if(curAngle == -360 || curAngle == 360) curAngle=0;
                    if(flag)
                        curAngle -= 90;
                    else
                        curAngle += 90;
                    if(curAngle == -360 || curAngle == 360) curAngle = 0;
                    imgControl.rotate({
                        angle: oldAngle,
                        animateTo: curAngle
                    });
                    imgControl.attr("curAngle", curAngle);
                    var resizeA = curAngle;
                    if(resizeA == -360 || resizeA == 360) resizeA = 0;
                    var h = imgControl.parent().height();
                    var _h = h * 0.98;
                    var imgH = imgControl.parent().height();
                    var imgW = imgControl.parent().width();
                    if(resizeA != 0 && resizeA != 180 && resizeA != -180)
                    {
                        if(imgW<imgH)
                        {
                            _h = Math.round(imgW * 0.65);
                            imgControl.css({"height":"auto","width": _h + "px", "margin-top":"80px"});
                        }
                        else
                        {
                            imgControl.css({"height":"auto","width": _h + "px", "margin-top":"80px"});
                        }
                    }
                    else
                    {
                        imgControl.css({"height":_h + "px","width":"auto", "margin-top":"auto"});
                    }
                }

				//Quick view on item, allows preview of large image in popup of item (If item has preview, provides next-prev options). Uses colorboc plugin
				window.quickView = function () {
					var _html = [];
					var _itemHTML = "<p><a href=\"HREF\" fileName=\"FILENAME\" rel=\"QUICKVIEW\" title=\"TITLE\">TITLE</a></p>"; // Basic html used in colorbox mode
					var _fileName = false;
					var basket = false;
					var elem = currentContext();
					if (elem) {
						var $curElem = $(elem);
						_fileName = unescape($curElem.find("a:first").attr("rel")); //filename will be available if initiated using context menu, and will be shown as initial image in quick preview
						basket = $curElem.hasClass("contextMenuItem");
					}
					var files = new Array();
					var allItems = basket ? $(document).data(o.BasketDataKey) : l;
					if(!allItems) allItems = [];
					if(allItems.length==0)return false;
					//Loop through items in current directory and build html for items which have preview
					for (var item = 0; item < allItems.length; item++) {
						var curItem = allItems[item];
						if (curItem.name) {
							var inValidImg = (curItem.privs.search(/slideshow/i) == -1 || curItem.preview == 0);
							if (!inValidImg) {
								var row = new Object();
								row['enabled'] = true;
								if(basket)
								{
									row['imageSrc'] = o.ajaxCallURL + '?command=getPreview&size=3&path=' + curItem['file'] + '&random='+Math.random()+'&frame=1';
									row["fileName"] = curItem['file'];
									row["name"] = curItem['name'];
								}
								else
								{
									row['imageSrc'] = o.ajaxCallURL + '?command=getPreview&size=3&path=' + curItem['href_path'] + '&random='+Math.random()+'&frame=1';
									row["fileName"] = curItem['href_path'];
									row["name"] = curItem['name'];
								}
								files.push(row);
							}
						}
					}
					if(files.length==0)return false;
					for (var item = 0; item < files.length; item++) {
						var curItem = files[item];
						var _generatedHTML = _itemHTML
						_generatedHTML = _generatedHTML.replace(/HREF/g, curItem.imageSrc);
						_generatedHTML = _generatedHTML.replace(/TITLE/g, curItem.name);
						_generatedHTML = _generatedHTML.replace(/FILENAME/g, curItem.fileName);
						_html.push(_generatedHTML);
					}
					$("#quickViewItems").remove();
					var quickViewItems = $("<div id='quickViewItems'></div>");
					quickViewItems.empty().append(_html.join(""));
					if (_fileName && $("a[fileName='" + _fileName + "']", quickViewItems).length > 0) {
						var curPic = $("a[fileName='" + _fileName + "']", quickViewItems).parent();
						quickViewItems.prepend(curPic.nextAll());
						quickViewItems.prepend(curPic);
					}
					if (_html.length > 0) {
						$("body").append(quickViewItems);
						quickViewItems.hide();
                        var cboxContent = $("#cboxContent");
                        var cboxLoadedContent = $("#cboxLoadedContent");
                        //Intiate colorbox
                        $("a[rel='QUICKVIEW']", quickViewItems).colorbox({
                            onClosed: function () {
                                $("#quickViewItems").remove();
                                $("#exifPanel").remove();
                            },
                            onLoad : function() {
                                if(typeof window.TooltipExifInfoKeys != "undefined")
                                {
                                    if($("#exifPanel").show().length==0)
                                    {
                                        $("body").append("<div id='exifPanel' class='exifInfoPanel'><div class='exifContent'><span class='exifClose'>x</span><div style='text-align:center;margin-bottom:10px;cursor:move;' class='moveHandle'><strong>: EXIF information :</strong></div><table style='width:100%;'></table></div><div class='showExifLink'>Show EXIF</div></div>");
                                        $("#exifPanel").draggable();
                                    }
                                    $("#exifPanel").find("table").html("<tr><td>N/A</td></tr>");
                                }
                            },
                            onComplete : function(){
                                var contextElem = $(this);
                                if(typeof window.TooltipExifInfoKeys != "undefined")
                                {
                                    getExifInfo(contextElem, function(exif){
                                        if(exif)
                                        {
                                            showExifInfo(exif, cboxContent, contextElem.attr("filename"));
                                        }
                                        else
                                            $("#exifPanel").find("table").html("<tr><td>N/A</td></tr>");
                                    });
                                }
                                if($.browser.msie && $.browser.version <= 8)
                                    return;
                                cboxContent.find(".rotateImgCounterClockwise, .rotateImgClockwise").remove();
                                cboxContent.find("#cboxClose").before("<span class='rotateImgCounterClockwise' title='"+getLocalizationKey("QuickViewRotateCounterClockwiseTooltipText")+"'></span><span class='rotateImgClockwise' title='"+getLocalizationKey("QuickViewRotateClockwiseTooltipText") +"'></span>");
                                $(".rotateImgClockwise, .rotateImgCounterClockwise", cboxContent).unbind().click(function(){
                                    rotateImage($("#cboxPhoto"), $(this).is(".rotateImgCounterClockwise"));
                                    $(this).blur();
                                    return false;
                                });
                            },
                            scrolling : false,
							photo: true,
							open: true,
                            minHeight : 400,
                            minWidth : 400,
							current: getLocalizationKey("QuickViewCurrentImagePositionText")
						});
					} else {
						$.growlUI(getLocalizationKey("QuickViewNothingToShowGrowlText"), getLocalizationKey("QuickViewNoItemsAvailableGrowlText"), o.GrowlTimeout, "");
					}
				}

                function showExifInfo(exif, parentElem, path)
                {
                    if(!parentElem || !exif)
                        return;
                    var items = window.TooltipExifInfoKeys.split(",");
                    var editableItems =  typeof window.EditeableExifInfoKeys != "undefined" ? window.EditeableExifInfoKeys.split(",") : [];
                    var exifPanel = $("#exifPanel");
                    if(items && items.length>0)
                    {
                        var exifInfo = "";
                        for(var i=0;i<items.length;i++)
                        {
                            var info = typeof exif[$.trim(items[i])] != "undefined" ? exif[$.trim(items[i])] : "N/A";
                            var editLink = "<span class='editExif'></span>";
                            if(!editableItems.has(items[i]))
                            {
                                editLink = "&nbsp;";
                            }
                            exifInfo += "<tr class='exifInfoRow' path='"+path+"' key='"+items[i]+"'' val='"+info+"'><td class='key'><span class='wordwrap'>"+items[i]+" :</span> </td><td class='val wordwrap'>"+info+"</td><td class='edit'>"+editLink+"</td></tr>";
                        }
                        exifPanel.find("table").html(exifInfo);
                        exifPanel.find(".exifClose").click(function(evt){
                            exifPanel.addClass("exifInfoPanelCollapsed");
                            evt.stopPropagation();
                            return false;
                        });
                        exifPanel.click(function(evt){
                            if(exifPanel.hasClass("exifInfoPanelCollapsed"))
                                exifPanel.removeClass("exifInfoPanelCollapsed")
                            evt.stopPropagation();
                            return false;
                        });

                        exifPanel.find(".editExif").click(function(){
                            var parentElem = $(this).closest("tr");
                            var key = parentElem.attr("key");
                            var val = parentElem.attr("val");
                            $("#exifEditPanel").remove();
                            if ($("#exifEditPanel").length == 0) {
                                $("body").append("<div id='exifEditPanel'></div>");
                                $("#exifEditPanel").append("<div class='exifEditPanel'>"+key+" :<br> <textarea style='margin:10px 0px;' cols='70' rows='8' class='valueField'>"+val+"</textarea></div>");
                            }
                            var $exifBox = $('#exifEditPanel');
                            $exifBox.dialog({
                                title : "Update EXIF information : ",
                                autoOpen: false,
                                closeOnEscape: true,
                                draggable: false,
                                width: 400,
                                modal: true,
                                buttons: { "Save": function() {
                                    var _value = $exifBox.find("textarea.valueField").val();
                                    $exifBox.append("<span class='waitP'>"+getLocalizationKey("loadingIndicatorText")+"</span>");
                                    $exifBox.find("span.error").remove();
                                    setExifInfo(parentElem.attr("path"), key, _value, function(msg){
                                        $exifBox.find("span.waitP").remove();
                                        if(msg && msg.response.toLowerCase() == "success")
                                        {
                                            $exifBox.dialog("close");
                                            parentElem.attr("val", _value);
                                            parentElem.find("td.val").text(_value);
                                        }
                                        else
                                            $exifBox.append("<span class='error'>Not saved, please try again.</span>");
                                    })
                                }, "Cancel": function() { $(this).dialog("close"); }},
                                resizable: false,
                                position: [false, 250],
                                zIndex : 10000,
                                open: function() {
                                    $('body').css('overflow','hidden');
                                    window.colorboxKeyDisabled = true;
                                },
                                close: function() {
                                    $('body').css('overflow','auto');
                                    window.colorboxKeyDisabled = false;
                                }
                            });
                            $exifBox.dialog("open");
                            $exifBox.find(".valueField").focus();
                        });
                    }
                    else
                    {
                        exifPanel.find("table").html("<tr><td>N/A</td></tr>");
                    }
                }

                function getExifInfo(elem, callback)
                {
                    var path = elem.attr("filename");
                    if(typeof window.exifInfoItems == "undefined")
                        window.exifInfoItems = {};
                    if(window.exifInfoItems[path])
                    {
                        callback(window.exifInfoItems[path]);
                        return;
                    }
                    var obj = {
                        command : "getPreview",
                        object_type : "exif",
                        path : crushFTPTools.encodeURILocal(unescape(path))
                    };
                    $.ajax({
                        type: "POST",
                        url: o.ajaxCallURL,
                        data: obj,
                        error: function (XMLHttpRequest, textStatus, errorThrown) {
                            errorThrown = errorThrown || "Error while getting EXIF info";
                            callback(false);
                        },
                        success: function (data) {
                            var exif = $.xml2json(data);
                            window.exifInfoItems[path] = exif;
                            callback(exif);
                        }
                    });
                }

                function setExifInfo(path, key, val, callback)
                {
                    var obj = {
                        command : "setPreview",
                        object_type : "exif",
                        exif_key : key,
                        exif_val : val,
                        path : crushFTPTools.encodeURILocal(unescape(path))
                    };
                    $.ajax({
                        type: "POST",
                        url: o.ajaxCallURL,
                        data: obj,
                        error: function (XMLHttpRequest, textStatus, errorThrown) {
                            errorThrown = errorThrown || "Error while getting EXIF info";
                            callback(false);
                        },
                        success: function (data) {
                            var exif = $.xml2json(data);
                            window.exifInfoItems[path] = false;
                            callback(exif);
                        }
                    });
                }

				//Method to expand all dirs in current listing to the first level
				window.expandDirsFirstLevel = function (expandItemsQueue) {
					var curPath = crushFTPTools.encodeURILocal(unescape(hashListener.getHash().toString().replace("#", "")));
					curPath = curPath || "/";
					var expandItems = $("table#filesContainer").find("tr[rootdir='" + crushFTPTools.decodeURILocal(curPath) + "']:visible");
					expandItemsQueue = expandItemsQueue || [];
					// Loop through items, find out which are not expanded. Make an array of such items and pass it to expandDir method
					expandItems.each(function () {
						var expandBtn = $(this).find("td.directory");
						if (!expandItemsQueue.has(escape(unescape(expandBtn.find("a").attr("rel")))) && expandBtn && !expandBtn.hasClass("expanded") && expandBtn.find("a").length > 0 && expandBtn.find("a").attr("rel")) {
							expandItemsQueue.push(escape(unescape(expandBtn.find("a").attr("rel"))));
						}
					});
					expandDir(expandItemsQueue); //Expand each items supplied as an array
				}

				//Expands directory passed as an array in parameter
				function expandDir(expandQueue) {
					if (expandQueue.length > 0) {
						var curDir = expandQueue.shift();
						curDir = $("table#filesContainer").find("span.expandButton[rel='" + curDir + "']");
						if (curDir.length > 0) {
							//Finds out relevant list item in listing and triggers expand event, once expand of current item completes it will recall expandDirsFirstLevel with same array passed to this method. Which will not have items that are expanded now in next call.
							curDir.trigger(o.folderEvent, function () {
								expandDirsFirstLevel(expandQueue);
							});
						} else {
							expandDirsFirstLevel(expandQueue);
						}
					} else {
						return;
					}
				}

				//performAction method is generally used in all context menu and main menu item's command
				window.performAction = function (elem, context) {
					var onBlockFn = null;
					if (elem == "expandFirstLevel") {
						//Expand first level of each dirs on list, treeview only
						if (currentView() == "Thumbnail") {
							$.growlUI(getLocalizationKey("TreeviewSpecificActionMsgTitleText"), getLocalizationKey("TreeviewSpecificActionMsgDescText"), o.GrowlTimeout, "growlError", o.GrowlWithCloseButton);
						} else {
							window.expandDirsFirstLevel(context);
						}
						return;
					} else if (elem == "upload") {
						//Open browser uploader window
						window.browserUploader(context);
						if($("div#filesBasket").dialog("isOpen"))
							$(".blockMsg, .popupWindow").css("z-index", "1003");
						return;
					} else if (elem == "quickView") {
						//Open quick view popup
						quickView(context);
						return;
					} else if(elem == "downloadLowRes")
					{
						//Download low res folder
						downloadLowRes(context);
						return;
					} else if (elem == "delete") {
						//Remove selected item
						window.delete_items(context);
						return;
					} else if (elem == "rename") {
						//Rename selected item
						performRenameAction(context);
						return;
					} else if (elem == "cut") {
						//Cut selected item
						doCopy(context, true);
						return;
					} else if (elem == "copy") {
						//Copy selected item
						doCopy(context);
						return;
					} else if (elem == "paste") {
						//Paste copied/cut items
						doPaste(context);
						return;
					} else if (elem == "zip") {
						//Zip selected items and download
						downloadAsZip(context);
						return;
					} else if (elem == "unzip") {
						//unzip selected items on server
						unzip(context);
						return;
					} else if (elem == "zipItems") {
                        //zip selected items on server
                        zipItems(context);
                        return;
                    } else if (elem == "download") {
						//Download selected items
						downloadItems(context);
						return;
					} else if (elem == "share") {
						//Open share window with selected items
						shareFile(context);
						return;
					} else if (elem == "quickShare") {
                        //Share items quickly, no popup
                        quickShareFile(context);
                    }else if (elem == "addToBasket") {
						//Add selected items to download basket
						addToBasket(context);
						return
					} else if (elem == "quickAdvancedDownload") {
						//Quickly download selected items using advanced download applet
						quickAdvancedDownload(context);
						return
					} else if (elem == "showBasket") {
						//Show download basket
						showDownloadBasket(context);
						return;
					} else if (elem == "copyDirectLink") {
						//Copy link of selected item, opens popup with link
						copypath(context);
						return;
					} else if (elem == "updateKeywords") {
						//Open popup to update keywords of selected items
						updateKeywords(context);
						return;
					} else if (elem == "batchComplete") {
						//Complete batch
						batchComplete(context);
						return;
					} else if (elem == "logout") {
						//Logout
						doLogout(context);
						return;
					} else if (elem == "search") {
						//Open search window
						var $elem = $("#searchDiv");
						$.blockUI({
							message: $elem,
							css: {
								width: '600px',
								padding: '15px',
								'margin-left': '-300px',
								left: '50%',
								position: 'absolute',
								top: '27%',
								'-webkit-border-radius': '10px',
								'-moz-border-radius': '10px',
								opacity: 1,
								'background-color': getPopupColor(true),
								'border': "1px solid " + getPopupColor()
							},
							onBlock: onBlockFn
						});
					} else if (elem == "shareOptionDiv") {
						//Open share option
						var $elem = $("#shareOptionDiv");
						$.blockUI({
							message: $elem,
							css: {
								width: '640px',
								padding: '15px',
								'margin-left': '-300px',
								left: '50%',
								position: 'absolute',
								top: '55px',
								'-webkit-border-radius': '10px',
								'-moz-border-radius': '10px',
								opacity: 1,
								'background-color': getPopupColor(true),
								'border': "1px solid " + getPopupColor()
							},
							onBlock: function () {
								try {
                                    if($("input#emailFrom", "#shareOptionDiv").val()=="")
                                    {
                                        $("input#emailFrom", "#shareOptionDiv")[0].focus();
                                        $("input#emailFrom", "#shareOptionDiv")[0].select();
                                    }
                                    else
                                    {
    									$("input#emailTo", "#shareOptionDiv")[0].focus();
    									$("input#emailTo", "#shareOptionDiv")[0].select();
                                    }
									$elem.parent().draggable({
										handle: "h2"
									});
								} catch (ex) {}
							}
						});
					} else if (elem == "slideshow") {
						//Open on page slideshow
						var basket = false;
						var el = $();
						if (context) {
							el = currentContext();
							if (el) {
								basket = el.hasClass("contextMenuItem");
							}
						}
						var $elem = $("#slideshowDiv");
						var viewportHeight = window.innerHeight ? window.innerHeight : $(window).height();
						var viewportWidth = $(window).width();
						viewportHeight = viewportHeight - (viewportHeight * 0.2);
						viewportWidth = viewportWidth - (viewportWidth * 0.1);
						$elem.find(".content").append($('div.slideshow'));
						$.blockUI({
							message: $elem,
							css: {
								width: viewportWidth + 'px',
								padding: '15px',
								'margin-left': '-' + (viewportWidth / 2) - 15 + 'px',
								left: '50%',
								position: 'absolute',
								top: '5px',
								'-webkit-border-radius': '10px',
								'-moz-border-radius': '10px',
								opacity: 1,
								'background-color': getPopupColor(false, false, false, true),
								'border': "1px solid " + getPopupColor()
							},
							onBlock: function () {
								var h = window.innerHeight ? window.innerHeight : $(window).height();
								h = h * 0.92;
								$("div.blockUI").css({
									"background-color": getPopupColor(false, false, false, true),
									"color": "white"
								});
								var destinationPath = unescape(hashListener.getHash().toString());
								if(basket)
								{
									if (currentView(basket) == "Thumbnail") {
										destinationPath = "#" + el.data("dataRow").path;
									}
									else{
										destinationPath = "#" + el.closest("tr").attr("rel");
									}
								}
								$elem.find("div.content").empty().append('<iframe frameborder="0" scrolling="auto" style="width: 100%; height:' + h + 'px;background-color: #000000;" name="cftp_iframeSS" id="cftp_iframeSS" src="/WebInterface/jQuery/slideshowView.html?fromBasket='+basket+'' + destinationPath + '" hspace="0" allowtransparency="false"></iframe>');
								$(window).bind("resize", function () {
									resetSlideShowDimensions();
								});
							},
							onUnblock: function () {
								$elem.find("div.content").empty();
							}
						});
						if($("div#filesBasket").dialog("isOpen"))
							$(".blockMsg").css("z-index", 1002);
					} else if (elem == "manageShares") {
                        window.popupManageShares();
					} else if (elem == "keywordsDiv") {
						//Show keywords
						var $elem = $("#keywordsDiv");
						$.blockUI({
							message: $elem,
							css: {
								width: '600px',
								padding: '15px',
								'margin-left': '-310px',
								left: '50%',
								position: 'absolute',
								top: '15%',
								'-webkit-border-radius': '10px',
								'-moz-border-radius': '10px',
								opacity: 1,
								'background-color': getPopupColor(true),
								'border': "1px solid " + getPopupColor()
							},
							onBlock: function () {
								$elem.parent().draggable({
									handle: "h2"
								});
							}
						});
					} else if (elem == "changeIcon") {
						//Open icon change window
						changeIcon(context);
					} else if(elem == "Preview") {
						mediaPreview(context);
					}
                    else if (elem == "downloadSyncApp") {
                        if(typeof context === "string")
                            downloadSyncApp(context);
                        else
                            downloadSyncApp();
                        return;
                    }
                    else if (elem == "downloadCrushFTPDrive") {
                        if(typeof context === "string")
                            downloadCrushFTPDrive(context);
                        else
                            downloadCrushFTPDrive();
                        return;
                    }
					else {
						$elem = $("#" + elem);
						if($elem && $elem.length>0)
						{
							$.blockUI({
								message: $elem,
								css: {
									width: '350px',
									padding: '15px',
									'margin-left': '-175px',
									left: '50%',
									position: 'absolute',
									top: '25%',
									'-webkit-border-radius': '10px',
									'-moz-border-radius': '10px',
									opacity: 1,
									'background-color': getPopupColor(true),
									'border': "1px solid " + getPopupColor()
								},
								onBlock: onBlockFn
							});
							if($("div#filesBasket").dialog("isOpen"))
							{
								$(".blockOverlay").css("z-index", "1002");
								$(".blockMsg").css("z-index", "1003");
							}
						}
					}
					try {
						$(".blockUI ").find("input[type='text']")[0].focus();
						$(".blockUI ").find("input[type='text']")[0].select();
					} catch (ex) {}
				}

				//Scroll position of window to target element
				window.scrollToElement = function ($target) {
					if ($target.length) {
						var targetOffset = $target.offset().top;
						$('html,body').animate({
							scrollTop: targetOffset
						}, 500, false);
						return false;
					}
				}

				//Reset slideshow dimensions
				window.resetSlideShowDimensions = function (_height) {
					if (_height) {
						$("div.slideshow").find("iframe").css("height", _height + "px");
					} else {
						var viewportHeight = window.innerHeight ? window.innerHeight : $(window).height();
						var viewportWidth = $(window).width();
						viewportHeight = viewportHeight - (viewportHeight * 0.2);
						viewportWidth = viewportWidth - (viewportWidth * 0.1);

						//Set the width and margin of popup to keep it in center if window resizes based on new viewport dimension
						$("div.blockUI.blockPage").css({
							width: viewportWidth + 'px',
							'margin-left': '-' + (viewportWidth / 2) - 15 + 'px',
							left: '50%'
						});
					}
				}

				//Close slideshow popup
				window.closeSlideshow = function () {
					$('#slideshowDiv').find('div.content').empty();
					$(window).unbind('resize');
					$.unblockUI();
				}

				//Set cookie to show/hide items start with a dot. Refresh view
				window.hideItemsStartingWithDot = function (flag) {
					var options = {
						path: '/',
						expires: 365
					};
					$.cookie(o.CookieHideItemStartingWithDot, flag, options);
					refreshView();
				}

				//Set cookie to show/hide checkbox columns. Refresh view
				window.hideCheckBoxColumn = function (flag) {
					var options = {
						path: '/',
						expires: 365
					};
					$.cookie(o.CookieHideCheckBoxColumn, flag, options);
					refreshView();
				}

				//Set cookie to show/hide filter box. Refresh view
				window.hideFilter = function (flag) {
					var options = {
						path: '/',
						expires: 365
					};
					$.cookie(o.CookieHideFilter, flag, options);
					refreshView();
				}

				//Set cookie to auto upload items as selection completes flag
				window.autoUploadFlagSet = function (flag) {
					var options = {
						path: '/',
						expires: 365
					};
					$.cookie(o.CookieAutoUploadFlag, flag, options);
                    if(flag)
                        $("#autoUploadFlag").attr("checked", "checked");
                    else
                        $("#autoUploadFlag").removeAttr("checked");
				}

				//Set cookie to auto load applet as page completes loading
				window.autoAppletFlagSet = function (flag) {
					var options = {
						path: '/',
						expires: 365
					};
					$.cookie(o.CookieAutoAppletFlag, flag, options);
				}

				//Set cookie to use compression in upload/download flag
				window.noCompressionFlagSet = function (flag) {
					var options = {
						path: '/',
						expires: 365
					};
					$.cookie(o.CookieNoCompressionFlag, flag, options);
				}

				//Command to start tunnel in applet to boost speed
				window.startTunnel = function () {
					o.uploadURL = "http://127.0.0.1:55555/WebInterface/function/?CrushAuth=" + $.cookie("CrushAuth");
					o.downloadURL = "http://127.0.0.1:55555/WebInterface/function/?CrushAuth=" + $.cookie("CrushAuth");
					if (!$(document).data("appletLoadedU")) $(document).data("appletLoadedU", false);
					if (!$(document).data("appletLoadedU")) {
						loadApplet(false, function () {
							runAppletCommand(false, "COMMAND=TUNNEL:::ACTION=START:::URL=" + window.location.toString(), false);
						});
					} else {
						runAppletCommand(false, "COMMAND=TUNNEL:::ACTION=START:::URL=" + window.location.toString(), false);
					}
				}

				//Command to stop tunnel in applet
				window.stopTunnel = function () {
					o.uploadURL = "/WebInterface/function/";
					o.downloadURL = "/WebInterface/function/";
					if ($(document).data("appletLoadedU")) {
						runAppletCommand(false, "COMMAND=TUNNEL:::ACTION=STOP", false);
					}
				}

				//Logout user
				window.doLogout = function (elem) {
                    window.logoutInitiated = true;
					$.ajax({
						type: "POST",
						url: o.ajaxCallURL,
						data: {
							command: "logout",
							random: Math.random()
						},
						error: function (XMLHttpRequest, textStatus, errorThrown) {
							$.cookie("CrushAuth", "", {
								path: '/',
								expires: -1
							});
							document.location = "/WebInterface/login.html";
						},
						success: function (msg) {
							//Remove CrushAuth cookie and redirect to login page
							$.cookie("CrushAuth", "", {
								path: '/',
								expires: -1
							});
							document.location = "/WebInterface/login.html";
						}
					});
				}

				//Batch complete method
				window.batchComplete = function (elem) {
					$.ajax({
						type: "POST",
						url: "/WebInterface/function/",
						data: {
							command: "batchComplete"
						},
						success: function (response) {
							var s = getActionResponseText(response);
							if (s.toUpperCase().indexOf("SUCCESS") >= 0) {
								$.growlUI(getLocalizationKey("BatchCompleteText"), getLocalizationKey("BatchComplete"), o.GrowlTimeout, "", o.GrowlWithCloseButton);
							} else $.growlUI(getLocalizationKey("BatchCompleteText"), s, o.GrowlTimeout, "", o.GrowlWithCloseButton);
						}
					});
				}

				//Change password method
				window.changePassword = function (elem) {
					if ($("#new_password1")[0].value != $("#new_password2")[0].value) {
						alert(getLocalizationKey("PasswordNotMatchingMsgText"));
					} /*else if ($("#new_password1")[0].value.length < 4) {
						alert(getLocalizationKey("PasswordMustBeComplexMsgText"));
					} */
					else {
						$.ajax({
							type: "POST",
							url: "/WebInterface/function/",
							data: {
								command: "changePassword",
								current_password: $("#current_password")[0].value,
								new_password1: $("#new_password1")[0].value,
								new_password2: $("#new_password2")[0].value
							},
							success: function (response) {
								var s = getActionResponseText(response);
								if (s.toUpperCase().indexOf("PASSWORD CHANGED") >= 0) {
									alert(getLocalizationKey("PasswordChangedMsgText"));
									doLogout();
								} else alert(s);
							}
						});
					}
					return false;
				}

				//Perform search in directory, make ajax call based on options selected and show result on screen
                window.startSearch = function (word) {
                    var searchDiv = $("#searchDiv");
                    var filterSearch = false;
                    if(searchDiv.is(":visible"))
                    {
                        searchDiv.block({
                            message:  getLocalizationKey("SearchProcessNotificationText") + ' <a id="cancelAjax" href="#" style="color:#FFF;font-size:10px;">'+ getLocalizationKey("SearchProcessCancelText") +'</a>',
                            css: {
                                border: 'none',
                                padding: '15px',
                                backgroundColor: '#000',
                                '-webkit-border-radius': '10px',
                                '-moz-border-radius': '10px',
                                color: '#fff',
                                top: '40%'
                            }
                        });
                    }
                    else
                    {
                        filterSearch = true;
                        var loadingIndicator = $("#loadingIndicator");
                        if($("#cancelAjaxFilter").is(":visible"))
                            $("#cancelAjaxFilter").click();
                        if(!word || word.length==0)
                        {
                            if($("#searchResultNotification").find("a:visible").length>0)
                                $("#searchResultNotification").find("a:visible").click();
                            loadingIndicator.dialog('close');
                            $("#cancelAjaxFilter").remove();
                            $("#filter").focus();
                            return false;
                        }
                        loadingIndicator.dialog('open');
                        loadingIndicator.after('<a id="cancelAjaxFilter" href="#" style="color: #000;font-size: 11px;text-align: center;display: block;margin-bottom: 10px;">'+ getLocalizationKey("SearchProcessCancelText") +'</a>');
                        $("#filter").focus();
                    }
                    var destinationPath = crushFTPTools.encodeURILocal(hashListener.getHash().toString().replace("#", ""));
                    destinationPath = destinationPath || "/"; //Path to perform search on
                    var $_Request = $.ajax({
                        type: "POST",
                        url: o.ajaxCallURL,
                        dataType: "json",
                        beforeSend: function(x) {
                            if(x && x.overrideMimeType) {
                                x.overrideMimeType("application/j-son;charset=UTF-8");
                            }
                        },
                        data: "path=" + destinationPath + "&" + $("#searchForm").serialize().toString().replace(/=on/g, '=true'),
                        success: function (data) {
                            var response = data.listing;
                            window.l = response;
                            window.curTreeItems = response;
                            $(document).data("searchData", response);
                            if(filterSearch)
                            {
                                loadingIndicator.dialog("option", "modal", false);
                                loadingIndicator.dialog('close');
                                $("#cancelAjaxFilter").remove();
                            }
                            searchDiv.unblock();
                            if (currentView() == "Thumbnail") {
                                renderListing($("#filesContainerDiv"), false, false, data, true);
                            } else {
                                renderListing($("#filesContainer"), false, false, data, true);
                            }
                            if(filterSearch)
                            {
                                $("#filter").val(word).focus();
                            }
                            $.unblockUI();
                        },
                        error: function (XMLHttpRequest, textStatus, errorThrown) {
                            errorThrown = errorThrown || "searching failed";
                            $.growlUI("Error : " + errorThrown, errorThrown, o.GrowlTimeout, "");
                        }
                    });

                    $("#cancelAjax, #cancelAjaxFilter").unbind().click(
                        function () {
                            if(filterSearch)
                            {
                                loadingIndicator.dialog('close');
                                $("#cancelAjaxFilter").remove();
                            }
                            else
                                searchDiv.unblock();
                            $_Request.abort();
                            return false;
                        }
                    );
                    return false;
                }

                window.browserUploader = function(context)
                {
                    if($.CrushFTP && $.CrushFTP.uploadBarHidden)
                    {
                        $("#fileRepo").show().trigger("visibilityChange");
                    }
                    else
                    {
                        if(!window.disableUploadBarAttentionAnimation)
                        {
                            $("#fileQueueInfo").effect("highlight", { color : "red" }, 1500);
                            $.growlUI(getLocalizationKey("uploadBarAttentionTitle"), getLocalizationKey("uploadBarAttentionText"), 5000, "growlWarning");
                        }
                    }
                }

				//Get upload form from  if exist, execute callback
				window.getUploadForm = function(callback, callback2) {
					if(typeof $(document).data("uploadFormHTML") != "undefined")
					{
						callback($(document).data("uploadFormHTML"));
						return;
					}
					var unique_upload_id = $(document).data("unique_upload_id") || generateRandomPassword(4);
					var $_Request = $.ajax({
						type: "POST",
						url: o.ajaxCallURL,
						data: "command=getCustomForm&form=uploadForm",
						error: function (XMLHttpRequest, textStatus, errorThrown) {
							$("#uploadDetailsTabAnchor").hide().next().click();
						},
						success: function (response) {
							var items = $.xml2json(response, true);
							var html = '';
							if (items.entries) {
								$("div.customtabs", "#browserFileUpload").find("a#uploadDetailsTabAnchor").show();
								var fields = items.entries[0].entries_subitem;
								html = '<table class="customForm" cellpadding="0" cellspacing="0">';
								html += '<tr style="display:none;"><td colspan="2"><input type="hidden" id="meta_UploadFormId" name="meta_UploadFormId" value="' + XMLValue(items.id[0]) + '"/><input type="text" id="meta_unique_upload_id" class="unique_upload_id" name="meta_unique_upload_id" value="'+unique_upload_id+'"/><input type="hidden" id="meta_UploadFormName" name="meta_UploadFormName" value="' + XMLValue(items.name[0]) + '"/><input type="hidden" id="meta_form_name" name="meta_form_name" value="' + XMLValue(items.name[0]) + '" /></td></tr><tr><td width="30%"></td><td width="70%"></td></tr>';
								for (var item in fields) {
									html += generateFormField(fields[item]);
								}
								html += '</table>';
							} else {
								if(callback2)
									callback2();
								else
									$("div.customtabs", "#browserFileUpload").find("a#uploadDetailsTabAnchor").hide().next().click();
							}
							$(document).data("uploadFormHTML", html);
							callback(html);
						}
					});
					return false;
				}

				//Get custom form from server, execute callback
				function getCustomForm(type, callback, typeName, welcomeFormShown) {
                    var obj = {
                        type: "POST",
                        url: o.ajaxCallURL,
                        data: "command=getCustomForm&form=" + type,
                        success: function (response) {
                            var items = $.xml2json(response, true);
                            var html = '';
                            var alwaysFlag = false;
                            if (items.always && items.always[0] && items.always[0].text) {
                                alwaysFlag = items.always[0].text == "true";
                            }
                            var formName = "";
                            if (items.name && items.name[0] && items.name[0].text) {
                                formName = items.name[0].text;
                            }
                            if (items.entries) {
                                var fields = items.entries[0].entries_subitem;
                                html = '<input type="hidden" id="meta_form_name" name="meta_form_name" value="' + formName + '" /><table class="customForm" cellpadding="0" cellspacing="0">';
                                for (var item in fields) {
                                    html += generateFormField(fields[item]);
                                }
                                html += '<tr><td colspan="2" style="text-align:right;padding-right:10px;border:0px;">';
                                if (type != "messageForm") {
                                    html += '<button value="Reset" id="resetPasteForm">Reset</button>&nbsp;&nbsp';
                                }
                                html += '<button class="submitForm" value="' + typeName + '" id="submit' + typeName + 'Form">' + typeName + '</button> </td>' + '<tr>';
                                html += '</table>';
                                callback(html, true, formName, alwaysFlag);
                            } else {
                                callback(html, false, formName, alwaysFlag);
                            }
                        }
                    };
                    if(welcomeFormShown)
                    {
                        obj.welcomeFormShown = welcomeFormShown;
                    }
					var $_Request = $.ajax(obj);
					return false;
				}

				//Validate custom forms
				window.validateForm = function (target, form) {
					form = form || $("table.customForm", "#divUploadPanel");
					var validated = true;
					//Loop through required items first
					form.find(".required_true:visible, .validateEmail, .validatePasswords, .validateSameValue").each(
					function () {
						var ignoreRdOnly = $(this).hasClass("futureDateField") || $(this).hasClass("dateField");
                        if(!ignoreRdOnly)
                           if($(this).is(":disabled") || $(this).attr("readonly")) return;
						if ($(this).hasClass("chkbox")) { //If it is checkbox
							if (!$(this).is(":checked") && $(this).closest("td").find("input:checked").length == 0) {
								$(this).parent().addClass("validationFail")
								if (validated) {
									$(this).parent().focus();
								}
								validated = false;
							} else {
								$(this).parent().removeClass("validationFail");
							}
						} else { //If another input type
							$(this).val($.trim($(this).val()));
							if ($(this).val().length == 0 && $(this).hasClass("required_true")) {
								$(this).addClass("validationFail");
								if (validated) {
									$(this).focus();
								}
								validated = false;
							} else {
								if($(this).hasClass("validateEmail"))
								{
									if ($(this).val().length > 0 && !validateEmail($(this).val(), true)) {
										$(this).addClass("validationFail emailFail");
										if (validated) {
											$(this).focus();
										}
										validated = false;
									}
									else if($(this).hasClass("emailFail"))
									{
										$(this).removeClass("validationFail emailFail");
									}
								}
                                else if($(this).hasClass("validatePasswords"))
                                {
                                    var nextPass = form.find("input[name='"+$(this).attr("name")+"2']");
                                    if(nextPass.length>0)
                                    {
                                        if ($.trim($(this).val()) != $.trim($(nextPass).val())) {
                                            $(this).addClass("validationFail passMatchFail");
                                            nextPass.addClass("validationFail passMatchFail");
                                            $(this).parent().find(".passwordDsntMatch").remove();
                                            $(this).after("<span class='requiredField passwordDsntMatch' style='float:none;'> "+getLocalizationKey("customFormPasswordMatchValidationFailedText")+"</span>");
                                            if (validated) {
                                                $(this).focus();
                                            }
                                            validated = false;
                                        }
                                        else if($(this).hasClass("emailFail") || $(this).hasClass("passMatchFail") || $(this).hasClass("matchFail"))
                                        {
                                            $(this).removeClass("validationFail passMatchFail");
                                            nextPass.removeClass("validationFail passMatchFail");
                                            form.find(".passwordDsntMatch").remove();
                                        }
                                        else if($(this).hasClass("required_true") && $(this).val().length>0)
                                        {
                                            $(this).removeClass("validationFail");
                                        }
                                    }
                                }
                                else
                                {
                                    $(this).removeClass("validationFail");
                                }
                                if($(this).hasClass("validateSameValue"))
                                {
                                    var compareWith = form.find("input[name='"+$(this).attr("compareWith")+"']");
                                    if(compareWith.length>0)
                                    {
                                        if ($.trim($(this).val()) != $.trim($(compareWith).val())) {
                                            $(this).addClass("validationFail matchFail");
                                            compareWith.addClass("validationFail matchFail");
                                            $(this).parent().find(".valueDsntMatch").remove();
                                            $(this).after("<span class='requiredField valueDsntMatch' style='float:none;'> "+getLocalizationKey("customFormCompareValueMatchValidationFailedText")+"</span>");
                                            if (validated) {
                                                $(this).focus();
                                            }
                                            validated = false;
                                        }
                                        else if($(this).hasClass("matchFail"))
                                        {
                                            $(this).removeClass("validationFail matchFail");
                                            compareWith.removeClass("validationFail matchFail");
                                            form.find(".valueDsntMatch").remove();
                                        }
                                        else if($(this).hasClass("required_true") && $(this).val().length>0)
                                        {
                                            $(this).removeClass("validationFail");
                                        }
                                    }
                                }
							}
						}
					});
					//Remove attention message, if exists already
					if (form.prev().hasClass("attention")) {
						form.prev().remove();
					}

					if (validated) {//If validated, allow click on submit
						$(target).removeClass("disabledClick");
                        form.find(".passwordDsntMatch").remove();
					} else {
						//Else show proper message, disable submit
						$(target).addClass("disabledClick");
						form.before("<div class='attention'>" + getLocalizationKey("FormValidationFailText") + "</div>");
						if(form.find(".emailFail").length>0)
						{
							form.prev().append("<div>" + getLocalizationKey("FormEmailValidationFailText") + "</div>");
						}
						form.prev().css("float", "none");
					}
					return validated; //Return result
				}

				//Highlight paste button if files are copied
				function highlightPasteButton() {
					if (($(document).data(o.CookieCopiedFiles) && $(document).data(o.CookieCopiedFiles).length > 0)) {
						$("div.mainNavigation").find("a:contains('Paste')").addClass("starredMenu");
					} else {
						$("div.mainNavigation").find("a:contains('Paste')").removeClass("starredMenu");
					}
					if ($("#browserFileUpload").find("h2").hasClass("spinner")) {
						$("ul.topnav").find("a[href='javascript:browserUploader();'], a[href='javascript:performAction(\'upload\');']").addClass("bouncing_loader");
					}
				}

				//Copy selected items
				window.doCopy = function (context, flag) {
					var action = "Copy";
					if (flag) action = "Cut";
					var _fileName = "";
					var elem = false;
					var basket = false;
                    var hasDirSelected = false;
					if (context) {
						elem = currentContext();
						if (elem) {
							var $curElem = $(elem);
                            if(window.cutCopyOnlyFiles)
                            {
                                if(!$curElem.hasClass('directory') && !$curElem.hasClass('directoryThumb'))
                                {
                                    _fileName = $curElem.find("a:first").attr("rel");
                                }
                                else
                                    hasDirSelected = true;
                            }
                            else
                            {
    							_fileName = $curElem.find("a:first").attr("rel");
                            }
    						basket = $curElem.hasClass("contextMenuItem");
						}
					}
					var checkedFiles = {};
					if(basket)
					{
						if (currentView(basket) == "Thumbnail") {
                            if(window.cutCopyOnlyFiles)
                            {
                                checkedFiles = $("#FileBasketList").find("li.fileBoxSelected.fileThumb:visible");
                                if(checkedFiles.length != $("#FileBasketList").find("li.fileBoxSelected:visible").length)
                                    hasDirSelected = true;
                            }
                            else
							    checkedFiles = $("#FileBasketList").find("li.fileBoxSelected:visible");
						} else {
                            if(window.cutCopyOnlyFiles)
                            {
                                checkedFiles = $("#FileBasketList").find("td.fileTR").parent().find("input.chkBox:visible:checked");
                                if(checkedFiles.length != $("#FileBasketList").find("input.chkBox:visible:checked").length)
                                    hasDirSelected = true;
                            }
                            else
                                checkedFiles = $("#FileBasketList").find("input.chkBox:visible:checked");
						}
					}
					else
					{
						if (currentView() == "Thumbnail") {
                            if(window.cutCopyOnlyFiles)
                            {
                                checkedFiles = $("#filesContainerDiv").find("li.fileBoxSelected.fileThumb:visible");
                                if(checkedFiles.length != $("#filesContainerDiv").find("li.fileBoxSelected:visible").length)
                                    hasDirSelected = true;
                            }
                            else
                                checkedFiles = $("#filesContainerDiv").find("li.fileBoxSelected:visible");
						} else {
                            if(window.cutCopyOnlyFiles)
                            {
                                checkedFiles = $("#filesListing").find("td.fileTR").parent().find("input.chkBox:visible:checked");
                                if(checkedFiles.length != $("#filesListing").find("input.chkBox:visible:checked").length)
                                    hasDirSelected = true;
                            }
                            else
                                checkedFiles = $("#filesListing").find("input.chkBox:visible:checked");
						}
					}
                    if(window.cutCopyOnlyFiles && hasDirSelected)
                    {
                        growl(action, getLocalizationKey("CopyOnlyFilesMessage"), true, 3500);
                    }
					if (checkedFiles.length == 0 && !elem) {
						if (flag) {
							$.growlUI(getLocalizationKey("NothingSelectedGrowlText"), getLocalizationKey("CutNoFilesSelectedMessage"), o.GrowlTimeout, "growlError");
						} else {
							$.growlUI(getLocalizationKey("NothingSelectedGrowlText"), getLocalizationKey("CopyNoFilesSelectedMessage"), o.GrowlTimeout, "growlError");
						}
						return;
					}
					var filesCopied = 0;
					var directoriesCopied = 0;
					var stringToCopy = action.toLowerCase();
					stringToCopy += "\r\n" + _fileName;
					if (window.listingInfo.selectedEverything) {
						var listItems = window.curTreeItems;
						if (window.listingInfo.filtered) {
							listItems = window.matchedItems;
						}
						for (var i = 0; i < listItems.length; i++) {
							var curItem = listItems[i];
                            var isdir = false;
                            if (curItem.type.toLowerCase() == "dir") {
                                isdir = true;
                                directoriesCopied += 1;
                            } else {
                                filesCopied += 1;
                            }
                            if(window.cutCopyOnlyFiles)
                            {
                                if(!isdir)
                                {
        							if (stringToCopy.length > 0) {
        								stringToCopy += "\r\n";
        							}
                                    stringToCopy += unescape(curItem.root_dir) + unescape(curItem.name) + "/";
                                }
                            }
                            else
                            {
                                if (stringToCopy.length > 0) {
                                    stringToCopy += "\r\n";
                                }
                                stringToCopy += unescape(curItem.root_dir) + unescape(curItem.name) + "/";
                            }
						}
					} else {
						if (elem) {
							var $curElem = $(elem);
							if ($curElem.hasClass("fileTR") || $curElem.hasClass("fileThumb")) {
								filesCopied += 1;
							} else {
                                if(!window.cutCopyOnlyFiles)
                                    directoriesCopied += 1;
							}
						}
						checkedFiles.each(function () {
							var parentElem = $(this);
							if (currentView(basket) != "Thumbnail") {
								parentElem = $(this).closest("tr");
							}
							var filePath = parentElem.find("a").attr("rel");
							filePath = filePath.replace("//", "/");
							if (_fileName != filePath) {
								stringToCopy += "\r\n" + filePath;
								if (currentView(basket) == "Thumbnail") {
									if (parentElem.hasClass("directoryThumb")) {
										directoriesCopied += 1;
									} else {
										filesCopied += 1;
									}
								} else {
									if (parentElem.find(".directory").length > 0) {
										directoriesCopied += 1;
									} else {
										filesCopied += 1;
									}
								}
							}
						});
					}
					var options = {
						path: '/',
						expires: 365
					};
					$(document).data(o.CookieCopiedFiles, stringToCopy);
					var msgToShow = getLocalizationKey("CopyActionGrowlText");
					if (flag) {
						msgToShow = getLocalizationKey("CutActionGrowlText");
					}
					msgToShow = msgToShow.replace("{0}", directoriesCopied);
					msgToShow = msgToShow.replace("{1}", filesCopied);
                    $.growlUI(action, msgToShow);

					highlightPasteButton();
					selectDeselectAllItems(false, false, basket);
				}

                window.dragAndMove = function(path, draggedItems, draggingNames)
                {
                    var _path = ""
                    try{
                        _path = crushFTPTools.decodeURILocal(path);
                        _path = crushFTPTools.encodeURILocal(unescape(unescape(path)));
                    }
                    catch(ex)
                    {
                        _path = crushFTPTools.encodeURILocal(path);
                    }
                    var obj = {
                        command: "getXMLListing",
                        format: "JSONOBJ",
                        path: _path,
                        random: Math.random()
                    };
                    var loadingIndicator = $("#loadingIndicator");
                    loadingIndicator.dialog("option", "modal", true);
                    loadingIndicator.dialog('open');
                    $.ajax({
                        type: "POST",
                        url: o.ajaxCallURL,
                        data: obj,
                        async: true,
                        dataType: "json",
                        beforeSend: function(x) {
                            if(x && x.overrideMimeType) {
                                x.overrideMimeType("application/j-son;charset=UTF-8");
                            }
                        },
                        success: function (data) {
                            loadingIndicator.dialog("option", "modal", false);
                            loadingIndicator.dialog('close');
                            var filesExist = [];
                            var fileItems = data.listing;
                            for (var i = 0; i < fileItems.length; i++) {
                                if(draggingNames.has(fileItems[i].name))
                                    filesExist.push(fileItems[i].name);
                            };
                            if(filesExist.length>0)
                            {
                                var fileExistConfirm = $("#fileExistConfirm");
                                var list = "";
                                if(filesExist.length>10)
                                {
                                    for (var i = 0; i < 10; i++) {
                                        var name = filesExist[i];
                                        list += "<li class='ui-widget ui-corner-all'>" + name + "</li>";
                                    };
                                    var count = filesExist.length - 10;
                                    list += "<li class='ui-priority-primary'>And "+ count + " more...</li>";
                                }
                                else
                                {
                                    for (var i = 0; i < filesExist.length; i++) {
                                        var name = filesExist[i];
                                        list += "<li class='ui-widget ui-corner-all'>" + name + "</li>";
                                    };
                                }
                                fileExistConfirm.find("ul").empty().append(list);
                                fileExistConfirm.dialog({
                                    autoOpen: true,
                                    draggable: true,
                                    width: 500,
                                    dialogClass : "confirmClass",
                                    title : "Confirm :",
                                    modal: true,
                                    buttons: [
                                    {
                                        text : "Stop",
                                        click : function(){
                                            $(this).dialog("close");
                                        }
                                    },
                                    {
                                        text : "Replace",
                                        click : function(){
                                            window.doPaste(false, path, draggedItems);
                                            $(this).dialog("close");
                                        }
                                    },
                                    {
                                        text : "Skip",
                                        click : function(){
                                            for (var i = 0; i < filesExist.length; i++) {
                                                var index = draggingNames.indexOf(filesExist[i]);
                                                if(index >=0)
                                                    draggedItems.remove(index+1);
                                            };
                                            console.log(draggedItems);
                                            if(draggedItems.length>1)
                                                window.doPaste(false, path, draggedItems);
                                            else
                                            {
                                                //nothing to move
                                            }
                                            $(this).dialog("close");
                                        }
                                    }
                                    ],
                                    resizable: false,
                                    open: function() {
                                        $('body').css('overflow','hidden');
                                    },
                                    close: function() {
                                        $('body').css('overflow','auto');
                                    }
                                });
                            }
                            else
                            {

                            }
                        }
                    });
                }

				//Paste copied items to target folder
				window.doPaste = function (context, target, draggedItems) {
                    var isDragDrop = false;
                    if(target && draggedItems)
                        isDragDrop = true;
					var $elem = $("div#pasteFormPanel");
					var elem = false;
					var basket = false;
                    if(!isDragDrop)
                    {
    					if (context) {
    						elem = currentContext();
    						if (elem) {
    							var $curElem = $(elem);
    							basket = $curElem.hasClass("contextMenuItem");
    						}
    					}
                        else
                        {
                            var checkedFiles;
                            if (currentView() == "Thumbnail")
                                checkedFiles = $("#filesContainerDiv").find("li.fileBoxSelected:visible");
                            else
                                checkedFiles = $("#filesListing").find("input.chkBox:visible:checked").closest("tr").find("td.columnName");
                            if(checkedFiles.length == 1)
                            {
                                if(checkedFiles.hasClass("directoryThumb") || checkedFiles.hasClass("directory"))
                                    elem = checkedFiles;
                                else
                                {
                                    $.growlUI(getLocalizationKey("PasteFormPasteButtonText"), getLocalizationKey("PasteSelectDirectoryWarning"), o.GrowlTimeout, "growlError");
                                    return false;
                                }
                            }
                            else
                            {
                                if(checkedFiles.length!=0)
                                {
                                    if(checkedFiles.filter(".directory, .directoryThumb").length>1)
                                        $.growlUI(getLocalizationKey("PasteFormPasteButtonText"), getLocalizationKey("PasteSelectSingleDirectoryWarning"), o.GrowlTimeout, "growlError");
                                    else
                                        $.growlUI(getLocalizationKey("PasteFormPasteButtonText"), getLocalizationKey("PasteSelectDirectoryWarning"), o.GrowlTimeout, "growlError");
                                    return false;
                                }
                            }
                        }
    					if (!$(document).data(o.CookieCopiedFiles)) { //If nothing copied
    						$.growlUI(getLocalizationKey("PasteFormPasteButtonText"), getLocalizationKey("PasteFormErrorNothingToPasteText"), o.GrowlTimeout, "growlError");
    						return false;
    					}
                    }

					//Paste items selected, show form if there's form to show on paste
					function pasteFiles(hasForm) {
						if (!validateForm(elem, $("div.pasteForm", "#pasteFormPanel"))) {
							return false;
						}
						$("#pasteFormPanel").find(".closeButton").click();
						var action = "Paste";
						var destinationPath = undefined;
                        if(!isDragDrop)
                        {
    						if (elem && !$(elem).hasClass("fileItem") && !$(elem).hasClass("fileThumb")) {
    							if (currentView(basket) != "Thumbnail") {
    								destinationPath = crushFTPTools.encodeURILocal(unescape($(elem).find("a:first").attr("rel")));
    							} else {
    								destinationPath = $(elem).find("a:first").attr("rel");
    							}
    						} else if ($(elem).hasClass("directoryThumb") || $(elem).hasClass("directory")) {
    							destinationPath = crushFTPTools.encodeURILocal(unescape(hashListener.getHash().toString().replace("#", "")));
    							destinationPath = destinationPath || "/";
    							destinationPath += $(elem).find("a").text();
    						} else {
    							destinationPath = crushFTPTools.encodeURILocal(unescape(hashListener.getHash().toString().replace("#", "")));
    							destinationPath = destinationPath || "/";
    						}
                        }
                        else
                            destinationPath = crushFTPTools.encodeURILocal(target);
						if (destinationPath) { //Target exists in context
                            var copiedItems = $(document).data(o.CookieCopiedFiles); //Items copied
							var items;
                            if(isDragDrop)
                                items = copiedItems = draggedItems;
                            else
                                items = copiedItems.split("\r\n");
                            if (copiedItems) {
								var curAction = items[0].toLowerCase();
								action = items[0].toLowerCase() + "_paste";
								var fileNames = "";
								for (var i = 1; i < items.length; i++) {
									if (fileNames.length > 0) {
										fileNames += "\r\n";
									}
									fileNames += crushFTPTools.encodeURILocal(unescape(items[i]));
								}
								//Build an object to submit to server
								var obj = {
									command: action,
									names: fileNames,
									destPath: destinationPath,
									random: Math.random()
								};

								//If has form attach form info
								if (hasForm) {
									var pasteForm = $("div.pasteForm", "#pasteFormPanel");
									var formClone = pasteForm.find("form");
									pasteForm = serializeForm(formClone[0]);
									pasteForm += "&command=" + action + "&names=" + fileNames + "&destPath=" + destinationPath + "&random=" + Math.random();
									obj = pasteForm;
								}
								if (currentView(basket) != "Thumbnail") {
									$("#filesListing").find("table").addClass("wait");
								} else {
									$("#filesListing").find("ul").addClass("wait");
								}
                                var loadingIndicator = $("#loadingIndicator");
                                if(isDragDrop)
                                {
                                    loadingIndicator.dialog("option", "modal", true);
                                    loadingIndicator.dialog('open');
                                }
								else
                                    $(".mainProcessIndicator").show();
								$.ajax({
									type: "POST",
									url: o.ajaxCallURL,
									data: obj,
									error: function (XMLHttpRequest, textStatus, errorThrown) {
										errorThrown = errorThrown || action + " failed";
										$.growlUI("Error : " + errorThrown, errorThrown, o.GrowlTimeout, "", o.GrowlWithCloseButton);
									},
									success: function (response) {
                                        if(isDragDrop)
                                        {
                                            loadingIndicator.dialog("option", "modal", false);
                                            loadingIndicator.dialog('close');
                                            try{
                                                window.disableVtip = false;
                                                if($('.ui-draggable-dragging').length>0)
                                                    $('.ui-draggable-dragging').draggable('option', 'revert', true).trigger('mouseup');
                                                $(".uiDragHover").removeClass('uiDragHover');
                                            }catch(e){}
                                        }
                                        else
										  $(".mainProcessIndicator").hide();
										var responseText = getActionResponseText(response);
										if (responseText.length > 0) {
											if (responseText.toString().toLowerCase() == "ok") {
												if (curAction == "cut") {
                                                    if(!isDragDrop)
													   $(document).removeData(o.CookieCopiedFiles);
												}
												highlightPasteButton();
												var curDestinationPath = crushFTPTools.encodeURILocal(unescape(hashListener.getHash().toString().replace("#", "")));
												curDestinationPath = curDestinationPath || "/";
												if (curDestinationPath != destinationPath) {
                                                    if(!isDragDrop)
													   setHashLocation(destinationPath);
                                                    else
                                                    {
                                                        setTimeout(function() {
                                                            setHashLocation(crushFTPTools.encodeURILocal(unescape(target)));
                                                        }, 200);
                                                    }
												} else {
													$(".refreshButton").click();
												}
											} else {
												$.growlUI(getLocalizationKey("PasteFormErrorHeaderText"), getLocalizationKey("PasteFormErrorDetailsText").replace("{0}", responseText), o.GrowlTimeout, "growlError", o.GrowlWithCloseButton);
												$(".refreshButton").click();
											}
										} else {
											if (curAction == "cut") {
                                                if(!isDragDrop)
												    $(document).removeData(o.CookieCopiedFiles);
											}
											highlightPasteButton();
                                            if(elem && elem.length>0)
                                            {
                                                if($(elem).hasClass("directoryThumb"))
                                                    elem.trigger('dblclick');
                                                else
                                                    elem.trigger('click');
                                            }
                                            else
                                                $(".refreshButton").click();
										}
										if (currentView(basket) != "Thumbnail") {
											$("#filesListing").find("table").removeClass("wait");
										} else {
											$("#filesListing").find("ul").removeClass("wait");
										}
									},
									error: function () {
										$(".mainProcessIndicator").hide();
										$.growlUI(getLocalizationKey("PasteFormErrorHeaderText"), getLocalizationKey("PasteFormErrorDetailsText").replace("{0}", "Probelm while executing paste command on server"), o.GrowlTimeout, "growlError", o.GrowlWithCloseButton);
										$(".refreshButton").click();
										if (currentView(basket) != "Thumbnail") {
											$("#filesListing").find("table").removeClass("wait");
										} else {
											$("#filesListing").find("ul").removeClass("wait");
										}
									}
								});
							} else {
								$.growlUI(getLocalizationKey("PasteFormPasteButtonText"), getLocalizationKey("PasteFormErrorNothingToPasteText"), o.GrowlTimeout, "growlError");
							}
							return false;
						}
					}

					if ($("#pasteFormPanel").length > 0) {
						//Get paste from from server, build and show in popup if exists
						getCustomForm("pasteForm", function (data, hasForm, formName) {
							if (hasForm) {
								var pasteForm = $("div.pasteForm", "#pasteFormPanel");
								pasteForm.html("<form id='frmPasteForm'>" + data + "</form>").find("table").css("text-align", "left");
								setCustomFormFieldAttributes(pasteForm);
								attachCalendarPopup(pasteForm);
								$("button#resetPasteForm", pasteForm).unbind().click(function (event) {
									pasteForm.clearForm();
									event.stopPropagation();
									event.preventDefault();
								}).val(getLocalizationKey("PasteFormResetButtonText")).text(getLocalizationKey("PasteFormResetButtonText"));
								$("button.submitForm", pasteForm).unbind().click(function (event) {
									event.stopPropagation();
									event.preventDefault();
									pasteFiles(true);
									return false;
								});
								pasteForm.find("input").keydown(function (evt) {
									var evt = (evt) ? evt : ((event) ? event : null);
									if (evt.keyCode == 13) {
										$("button.submitForm", pasteForm).click();
										return false;
									} else if (evt.keyCode == 27) {
										$("button#resetPasteForm", pasteForm).click();
										return false;
									}
								});
								$.blockUI({
									message: $elem,
									css: {
										border: 'none',
										width: '650px',
										padding: '15px',
										'border': '1px solid ' + getPopupColor(),
										'background-color': getPopupColor(true),
										'margin-left': '-320px',
										left: '50%',
										position: 'absolute',
										top: '10%',
										'-webkit-border-radius': '10px',
										'-moz-border-radius': '10px',
										opacity: 1
									}
								});
							} else {
								pasteFiles();
							}
						}, getLocalizationKey("PasteFormPasteButtonText"));
					}
					else {
						pasteFiles();
					}
				}

				//Download selected items as a zip
				window.downloadAsZip = function (context, isFolder, isBasket) {
					var action = "Zip";
					var _fileName = "";
					var elem = {};
					var checkedFiles = {};
					var stringToCopy = "";
					var ItemsToDownload = [];
					var basket = isBasket || false;
					if (window.listingInfo.selectedEverything && !window.listingInfo.isSearchResult && !window.listingInfo.filtered) { //If all items in current directory is selected, pass directory name as a parameter, it will download whole directory as zip. No need to pass every item
						stringToCopy = "/";
						if (hashListener.getHash() && hashListener.getHash().toString() != "") {
							stringToCopy = hashListener.getHash().toString().replace("#", "");
						}
					} else if ((window.listingInfo.selectedEverything && window.listingInfo.isSearchResult) || (window.listingInfo.selectedEverything && window.listingInfo.filtered)) {
						//If not all items selected, loop through items selected and make a list
						var listItems = window.curTreeItems;
						if (window.listingInfo.filtered) {
							listItems = window.matchedItems;
						}
						for (var i = 0; i < listItems.length; i++) {
							var curItem = listItems[i];
							if (stringToCopy.length > 0) {
								stringToCopy += "\r\n";
							}
							var filePath = unescape(curItem.root_dir) + unescape(curItem.name);
							filePath = filePath.replace("//", "/");
							if (!ItemsToDownload.has(filePath)) {
								ItemsToDownload.push(filePath);
								stringToCopy += ":" + filePath;
							}
						}
					} else {
						if (!isFolder) {
							if (context) {
								elem = currentContext();
								if(isBasket) elem = context;
								if (elem) {
									var $curElem = $(elem);
									_fileName = $curElem.find("a:first").attr("rel");
									basket = $curElem.hasClass("contextMenuItem");
								}
							}
							if (currentView(basket) == "Thumbnail") {
								if(basket)
								{
									checkedFiles = $("#FileBasketList").find("li.fileBoxSelected:visible");
								}
								else
								{
									checkedFiles = $("#filesContainerDiv").find("li.fileBoxSelected:visible");
								}
							} else {
								if(basket)
								{
									checkedFiles = $("#FileBasketList").find("input.chkBox:visible:checked");
								}
								else
								{
									checkedFiles = $("#filesListing").find("input.chkBox:visible:checked");
								}
							}
							if (_fileName.length > 0) {
								checkedFiles.push($(elem));
							}
						} else {
							checkedFiles = context;
						}
						checkedFiles.each(function () {
							if (currentView(basket) != "Thumbnail") {
								var parentElem = $(this).closest("tr");
								var filePath = unescape(parentElem.find("a").attr("rel"));
								var dirContext = parentElem.attr("rel");
								var dirPath = parentElem.parent().find("a[rel='" + dirContext + "']");
								if (dirPath) {
									dirPath = dirPath.closest("tr");
									if (dirPath && dirPath.find("input.chkBox").is(":checked")) {
										return;
									}
								}
								filePath = filePath.toString();
								filePath = filePath.replace("//", "/");
								filePath = filePath.toString();
								if (!ItemsToDownload.has(filePath)) {
									ItemsToDownload.push(filePath);
									stringToCopy += ":" + filePath;
								}
							} else {
								var parentElem = $(this);
								var filePath = parentElem.find("a").attr("rel");
								filePath = filePath.toString();
								var dirContext = parentElem.attr("rel");
								var dirPath = parentElem.parent().find("a[rel='" + dirContext + "']");
								if (dirPath) {
									if (dirPath && dirPath.hasClass("fileBoxSelected")) {
										return;
									}
								}
								filePath = filePath.replace("//", "/");
								filePath = filePath.toString();
								if (!ItemsToDownload.has(filePath)) {
									ItemsToDownload.push(filePath);
									stringToCopy += ":" + filePath;
								}
							}
						});
					}
					if (stringToCopy.length == 0) {//If nothing selected
						$.growlUI(action, getLocalizationKey("NothingSelectedGrowlText"), o.GrowlTimeout, "growlError");
					} else {
                        if(window.promptZipNameWhileDownloading)
                        {
                            $("#zipNamePanel").remove();
                            var promptTemplate = "<div class='zipNamePanel'><h2>" + getLocalizationKey("ZipNameWindowHeaderText") + "</h2><br><div style='text-align:left;'><input type='text' class='zipName' style='width:300px;' /><br><div class='cancelButton' style='float:right;margin-left:10px;'>" + getLocalizationKey("ZipNamePanelCancelLinkText") + "</div><div class='saveButton' style='float:right;'>" + getLocalizationKey("ZipNamePanelSaveLinkText") + "</div></div></div>";
                            $("body").append("<div id='zipNamePanel'>" + promptTemplate + "</div>");
                            var $zipNameBox = $("#zipNamePanel").hide();
                            $.blockUI({
                                message: $zipNameBox,
                                css: {
                                    padding: '10px 10px 20px 30px',
                                    'background-color': getPopupColor(true),
                                    'border': "1px solid " + getPopupColor(),
                                    '-webkit-border-radius': '10px',
                                    '-moz-border-radius': '10px',
                                    color: '#000',
                                    opacity: 0.9,
                                    top: 100,
                                    left: '40%',
                                    width: '305px'
                                },
                                onBlock : function()
                                {
                                    $zipNameBox.parent().css("top","200px");
                                    if($("div#filesBasket").dialog("isOpen"))
                                    {
                                        $(".blockOverlay").css("z-index", "1002");
                                        $(".blockMsg").css("z-index", "1003");
                                        $("div#filesBasket").parent().css("z-index", "1001");
                                    }
                                },
                                onUnblock : function()
                                {
                                    if($("div#filesBasket").dialog("isOpen"))
                                    {
                                        $("div#filesBasket").parent().css("z-index", "1003");
                                    }
                                }
                            });
                            $zipNameBox.find(".zipName").val("archive.zip").focus();
                            $zipNameBox.find(".cancelButton").unbind().click(
                               function () {
                                    $.unblockUI();
                                    $("#syncAppNamePanel").remove();
                                    if($("div#filesBasket").dialog("isOpen"))
                                    {
                                        $("div#filesBasket").parent().css("z-index", "1003");
                                    }
                            });
                            $zipNameBox.find(".saveButton").unbind().click(
                            function () {
                                var newName = $zipNameBox.find(".zipName").val();
                                if(!newName.toLowerCase().endsWith(".zip"))
                                    newName = newName + ".zip";
                                submitAction({
                                    '#command': "downloadAsZip",
                                    '#zipName' : newName,
                                    '#path': crushFTPTools.encodeURILocal("/"),
                                    '#paths': crushFTPTools.encodeURILocal(unescape(stringToCopy)),
                                    '#random': Math.random()
                                });
                                selectDeselectAllItems(false, false, basket);
                                $.growlUI(getLocalizationKey("DownloadStartedAlertTitleText"), getLocalizationKey("DownloadStartedAlertDescText"), o.GrowlTimeout);
                                if($("div#filesBasket").dialog("isOpen"))
                                {
                                    $("div#filesBasket").parent().css("z-index", "1003");
                                }
                            });
                            $zipNameBox.find(".zipName").unbind().keyup(
                            function (evt) {
                                var evt = (evt) ? evt : ((event) ? event : null);
                                if (evt.keyCode == 13) {
                                    $zipNameBox.find(".saveButton").click();
                                    return false;
                                } else if (evt.keyCode == 27) {
                                    $zipNameBox.find(".cancelButton").click();
                                    return false;
                                }
                            });
                        }
                        else
                        {
    						//Submit action
    						submitAction({
    							'#command': "downloadAsZip",
    							'#path': crushFTPTools.encodeURILocal("/"),
    							'#paths': crushFTPTools.encodeURILocal(unescape(stringToCopy)),
    							'#random': Math.random()
    						});
    						selectDeselectAllItems(false, false, basket);
    						$.growlUI(getLocalizationKey("DownloadStartedAlertTitleText"), getLocalizationKey("DownloadStartedAlertDescText"), o.GrowlTimeout);
                        }
					}
				}

                //Zip selected items on server
                window.zipItems = function(context)
                {
                    window.unzip(context, true);
                }

				//Unzip selected items on server
				window.unzip = function (context, isZip) {
					var action = "unzip";
					var _fileName = "";
					var elem = false;
					var basket = false;
					if (context) {
						elem = currentContext();
						if (elem) {
							var $curElem = $(elem);
							_fileName = $curElem.find("a:first").attr("rel");
							basket = $curElem.hasClass("contextMenuItem");
						}
					}
					var checkedFiles = {};
					if(basket)
					{
						if (currentView(basket) == "Thumbnail") {
							checkedFiles = $("#FileBasketList").find("li.fileBoxSelected:visible");
						} else {
							checkedFiles = $("#FileBasketList").find("input.chkBox:visible:checked");
						}
					}
					else
					{
						if (currentView() == "Thumbnail") {
							checkedFiles = $("#filesContainerDiv").find("li.fileBoxSelected:visible");
						} else {
							checkedFiles = $("#filesListing").find("input.chkBox:visible:checked");
						}
					}
					if (checkedFiles.length == 0 && !elem) {
						$.growlUI(getLocalizationKey("NothingSelectedGrowlText"), getLocalizationKey("UnzipNoFilesSelectedMessage"), o.GrowlTimeout, "growlError");
						return;
					}
					var filesCopied = 0;
					var directoriesCopied = 0;
					var stringToCopy = _fileName;
					var _strMsg = stringToCopy;
					var msgToShow = getLocalizationKey("DeleteConfirmationMessageText");
					if (window.listingInfo.selectedEverything) {
						var listItems = window.curTreeItems;
						if (window.listingInfo.filtered) {
							listItems = window.matchedItems;
						}
						for (var i = 0; i < listItems.length; i++) {
							var curItem = listItems[i];
							if (stringToCopy.length > 0) {
								stringToCopy += "\r\n";
							}
							stringToCopy += unescape(curItem.root_dir) + unescape(curItem.name) + "/";
						}
						var curDir = "/";
						if (hashListener.getHash() && hashListener.getHash().toString() != "") {
							curDir = unescape(hashListener.getHash().toString().replace("#", ""));
						}
					} else {
						if (elem) {
							var $curElem = $(elem);
							if ($curElem.hasClass("fileTR") || $curElem.hasClass("fileThumb") || $curElem.hasClass("fileThumb")) {
								filesCopied += 1;
							} else {
								directoriesCopied += 1;
							}
						}
						var notDisplayed = 0;
						checkedFiles.each(function () {
							var parentElem = $(this);
							if (currentView(basket) != "Thumbnail") {
								parentElem = $(this).closest("tr");
							}
							var filePath = unescape(parentElem.find("a").attr("rel"));
							filePath = unescape(filePath.replace("//", "/"));
							if (_fileName != filePath) {
								if (stringToCopy.length > 0) {
									stringToCopy += "\r\n";
								}
								stringToCopy += (filePath);
								if (directoriesCopied + filesCopied < 5) {
									if (_strMsg.length > 0) {
										_strMsg += "\r\n";
									}
									_strMsg += filePath;
								} else {
									notDisplayed += 1;
								}
								if (currentView(basket) != "Thumbnail") {
									if (parentElem.find(".directory").length > 0) {
										directoriesCopied += 1;
									} else {
										filesCopied += 1;
									}
								} else {
									if (parentElem.hasClass("directoryThumb")) {
										directoriesCopied += 1;
									} else {
										filesCopied += 1;
									}
								}
							}
						});
					}
					var fileName = stringToCopy;
					var obj = {
						command: "unzip",
						names: crushFTPTools.encodeURILocal(unescape(fileName)),
						random: Math.random()
					};
                    if(isZip)
                    {
                        var destinationPath = hashListener.getHash().toString().replace("#", "");
                        destinationPath = destinationPath || "/";
                        obj.command = "zip";
                        obj.path = destinationPath;
                        $.growlUI(getLocalizationKey("ZipStartedAlertTitleText"), getLocalizationKey("ZipStartedAlertDescText"), o.GrowlTimeout);
                    }
                    else
					   $.growlUI(getLocalizationKey("UnzipStartedAlertTitleText"), getLocalizationKey("UnzipStartedAlertDescText"), o.GrowlTimeout);
					$.ajax({
						type: "POST",
						url: o.ajaxCallURL,
						data: obj,
						success: function (response) {
							var responseText = getActionResponseText(response);
							if (responseText.length > 0) {
                                if(isZip)
                                {
								    $.growlUI("Zip Selected Items : ", responseText, o.GrowlTimeout, false);
                                }
                                else
                                {
                                    $.growlUI(getLocalizationKey("ProblemWhileUnzipGrowlText"), getLocalizationKey("ProblemWhileUnzipDescGrowlText") + responseText, o.GrowlTimeout, "growlError", o.GrowlWithCloseButton);
                                }
								if(!basket)
									$(".refreshButton").click();
							} else {
                                if(isZip)
								    $.growlUI(getLocalizationKey("ZipCompletedAlertTitleText"), getLocalizationKey("ZipCompletedAlertDescText"), o.GrowlTimeout);
                                else
                                    $.growlUI(getLocalizationKey("UnzipCompletedAlertTitleText"), getLocalizationKey("UnzipCompletedAlertDescText"), o.GrowlTimeout);

								$("#filesContainer").find("input.chkBoxAll").removeAttr("checked");
								if(!basket)
									$(".refreshButton").click();
							}
						},
						error: function () {
							if(isZip)
                            {
                                $.growlUI(getLocalizationKey("ProblemWhileZipGrowlText"), getLocalizationKey("ProblemWhileZipDescGrowlText") + responseText, o.GrowlTimeout, "growlError", o.GrowlWithCloseButton);
                            }
                            else
                            {
                                $.growlUI(getLocalizationKey("ProblemWhileUnzipGrowlText"), getLocalizationKey("ProblemWhileUnzipDescGrowlText") + responseText, o.GrowlTimeout, "growlError", o.GrowlWithCloseButton);
                            }
							if(!basket)
								$(".refreshButton").click();
						}
					});
					selectDeselectAllItems(false);
				}

				//Delete selected items
				window.delete_items = function (context) {
					var action = "delete";
					var _fileName = "";
					var elem = false;
					var basket = false;
					if (context) {
						elem = currentContext();
						if (elem) {
							var $curElem = $(elem);
							_fileName = $curElem.find("a:first").attr("rel");
							basket = $curElem.hasClass("contextMenuItem");
						}
					}
					var checkedFiles = {};
					if(basket)
					{
						if (currentView(basket) == "Thumbnail") {
							checkedFiles = $("#FileBasketList").find("li.fileBoxSelected:visible");
						} else {
							checkedFiles = $("#FileBasketList").find("input.chkBox:visible:checked");
						}
					}
					else
					{
						if (currentView() == "Thumbnail") {
							checkedFiles = $("#filesContainerDiv").find("li.fileBoxSelected:visible");
						} else {
							checkedFiles = $("#filesListing").find("input.chkBox:visible:checked");
						}
					}

					if (checkedFiles.length == 0 && !elem) {
						$.growlUI(getLocalizationKey("NothingSelectedGrowlText"), getLocalizationKey("DeleteNoFilesSelectedMessage"), o.GrowlTimeout, "growlError");
						return;
					}
					var filesCopied = 0;
					var directoriesCopied = 0;
					var stringToCopy = _fileName;
					var _strMsg = stringToCopy;
					var msgToShow = getLocalizationKey("DeleteConfirmationMessageText");
					if (window.listingInfo.selectedEverything) {
						var listItems = window.curTreeItems;
						if (window.listingInfo.filtered) {
							listItems = window.matchedItems;
						}
						for (var i = 0; i < listItems.length; i++) {
							var curItem = listItems[i];
							if (stringToCopy.length > 0) {
								stringToCopy += "\r\n";
							}
							stringToCopy += unescape(curItem.root_dir) + unescape(curItem.name) + "/";
						}
						var curDir = "/";
						if (hashListener.getHash() && hashListener.getHash().toString() != "") {
							curDir = unescape(hashListener.getHash().toString().replace("#", ""));
						}
						msgToShow = getLocalizationKey("DeleteConfirmationMessageRemoveAllItemsInDirText");
						msgToShow = msgToShow.replace("{folder_name}", curDir);
						msgToShow = msgToShow.replace("{count}", listItems.length);
					} else {
						if (elem) {
							var $curElem = $(elem);
							if ($curElem.hasClass("fileTR") || $curElem.hasClass("fileThumb") || $curElem.hasClass("fileThumb")) {
								filesCopied += 1;
							} else {
								directoriesCopied += 1;
							}
						}
						var notDisplayed = 0;
						checkedFiles.each(function () {
							var parentElem = $(this);
							if (currentView(basket) != "Thumbnail") {
								parentElem = $(this).closest("tr");
							}
							var filePath = unescape(parentElem.find("a").attr("rel"));
							filePath = unescape(filePath.replace("//", "/"));
							if (unescape(_fileName) != filePath) {
								if (stringToCopy.length > 0) {
									stringToCopy += "\r\n";
								}
								stringToCopy += (filePath);
								if (directoriesCopied + filesCopied < 5) {
									if (_strMsg.length > 0) {
										_strMsg += "\r\n";
									}
									_strMsg += filePath;
								} else {
									notDisplayed += 1;
								}
								if (currentView(basket) != "Thumbnail") {
									if (parentElem.find(".directory").length > 0) {
										directoriesCopied += 1;
									} else {
										filesCopied += 1;
									}
								} else {
									if (parentElem.hasClass("directoryThumb")) {
										directoriesCopied += 1;
									} else {
										filesCopied += 1;
									}
								}
							}
						});
						_strMsg = unescape(_strMsg);
						if (notDisplayed > 0) {
							_strMsg += "\n\nand " + notDisplayed + " other item(s)";
						}
						msgToShow = msgToShow.replace("{0}", directoriesCopied);
						msgToShow = msgToShow.replace("{1}", filesCopied);
						msgToShow = msgToShow.replace("{2}", '\n' + _strMsg + '\n\n');
					}
					if (confirm(msgToShow)) {
						var fileName = stringToCopy;
						var obj = {
							command: "delete",
							names: crushFTPTools.encodeURILocal(unescape(fileName)),
							random: Math.random()
						};
                        var _loadingIndicator = $("#loadingIndicator").dialog({modal : true});
                        _loadingIndicator.dialog("open");
						$.ajax({
							type: "POST",
							url: o.ajaxCallURL,
							data: obj,
							success: function (response) {
                                _loadingIndicator.dialog({modal : false});
                                _loadingIndicator.dialog("close");
								var responseText = getActionResponseText(response);
								if (responseText.length > 0) {
									$.growlUI(getLocalizationKey("ProblemWhileDeletingGrowlText"), getLocalizationKey("ProblemWhileDeletingDescGrowlText") + responseText, o.GrowlTimeout, "growlError", o.GrowlWithCloseButton);
									$(".refreshButton").click();
								} else {
									$("#filesContainer").find("input.chkBoxAll").removeAttr("checked");
									$(".refreshButton").click();
									if(basket)
									{
										if (currentView(basket) != "Thumbnail")
										{
											checkedFiles.each(function(){
												$(this).closest("tr").find(".fileRemoveFromBasketTree").trigger("click");
											});
										}
										else
										{
											checkedFiles.each(function(){
												$(this).find(".fileRemoveFromBasket").trigger("click");
											});
										}
									}
								}
							},
							error: function () {
                                _loadingIndicator.dialog({modal : false});
                                _loadingIndicator.dialog("close");
								$.growlUI(getLocalizationKey("ProblemWhileDeletingGrowlText"), getLocalizationKey("ProblemWhileDeletingDescGrowlText"), o.GrowlTimeout, "growlError", o.GrowlWithCloseButton);
								$(".refreshButton").click();
							}
						});
					}
					selectDeselectAllItems(false, false, basket);
				}

				//Create directory
				window.makedir = function (fileName, callback) {
					fileName = fileName || $("#txtNewFolder").val();
					if (fileName.toString().length == 0) {
						return;
					}
					fileName = fileName.replace(/\//g, o.folderNameSpecialCharacterSubstitute).replace(/:/g, o.folderNameSpecialCharacterSubstitute);
					var filePath = unescape(hashListener.getHash().toString().replace("#", ""));
					if (filePath.length == 0) {
						filePath = "/";
					}
					if ($("#createFolder").data("parameter")) {
						var param = $("#createFolder").data("parameter");
						filePath = param.find("a").attr("rel");
					}
					var newFolderName = crushFTPTools.encodeURILocal(filePath + fileName + "/");
					var obj = {
						command: "makedir",
						path: newFolderName,
						random: Math.random()
					};
					$.ajax({
						type: "POST",
						url: o.ajaxCallURL,
						data: obj,
						success: function (response) {
							var responseText = getActionResponseText(response);
							if (responseText.length > 0) {
								if (responseText.toString().toLowerCase() == "ok") {
                                    $(".refreshButton").click();
                                    if(callback)
                                        callback(true);
                                } else {
                                    $.growlUI(getLocalizationKey("ProblemWhileCreatingFolderGrowlText"), getLocalizationKey("ProblemWhileCreatingFolderDescGrowlText") + responseText, o.GrowlTimeout, "growlError", o.GrowlWithCloseButton);
                                    if(callback)
                                        callback(false);
                                }
							} else {
                                if(callback)
                                {
                                    callback(true);
                                    $(".refreshButton").click();
                                }
                                else
                                {
    								$.unblockUI();
    								if ($("#chkNavigateAfterMkdir").is(":checked")) {
    									newFolderName = escape(crushFTPTools.decodeURILocal(newFolderName));
    									setHashLocation(newFolderName);
    								} else {
    									$(".refreshButton").click();
    								}
                                }
							}
						},
						error: function () {
							$.growlUI(getLocalizationKey("ProblemWhileCreatingFolderGrowlText"), getLocalizationKey("ProblemWhileCreatingFolderDescGrowlText"), o.GrowlTimeout, "growlError", o.GrowlWithCloseButton);
						}
					});
				}

				//General form field based on data passed
				function generateFormField(data) {
					var html = '';
					var randomId = "";
					var possible = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
					for (var i = 0; i < 5; i++)
					randomId += possible.charAt(Math.floor(Math.random() * possible.length)); //Generate random Id for field
					var requiredField = (data.required && XMLValue(data.required[0]) == "true") ? "<span class='requiredField'>*</span>" : "";
					if (!data.type || (data.type[0].text != 'label' && !data.name)) {
						return "";
					}
					var controlName = "";
					if(data.name)
					{
						controlName = XMLValue(data.name[0]);
					}
					switch (data.type[0].text) {
					case "label":
						//Generate label, with value
						var labelL = XMLValue(data.label[0]);
						var labelR = XMLValue(data.value[0]);
                        var labelName = "label_" + randomId;
                        try{
                            if(data.name && data.name.length>0)
                                labelName = XMLValue(data.name[0]);
                        }catch(ex){
                            labelName = "label_" + randomId;
                        }
                        var loadPage = false;
                        var loadLeft = false;
                        if(labelL.indexOf("{get:")>=0)
                        {
                            var _index = labelL.indexOf("{get:");
                            loadPage = labelL.substring(labelL.indexOf("{get:") + 5, labelL.length);
                            loadPage = loadPage.substring(0, loadPage.indexOf("}"));
                            loadLeft = true;
                        }
                        else if(labelR.indexOf("{get:")>=0)
                        {
                            var _index = labelR.indexOf("{get:");
                            loadPage = labelR.substring(labelR.indexOf("{get:") + 5, labelR.length);
                            loadPage = loadPage.substring(0, loadPage.indexOf("}"));
                        }
                        if(loadPage)
                        {
                            if(labelR.length==0)
                                html = '<tr>' + '<td colspan="2" class="formValFull loadPage" page="'+loadPage+'"><label name="meta_'+labelName+'">' + XMLValue(data.label[0]) + '</label></td><tr>';
                            else
                            {
                                if(loadLeft)
                                    html = '<tr>' + '<td class="formLabel loadPage" page="'+loadPage+'">' + labelL + ' ' + requiredField + '</td>' + '<td class="formVal"><label name="meta_'+labelName+'">' + labelR + '</label></td>' + '<tr>';
                                else
                                    html = '<tr>' + '<td class="formLabel">' + labelL + ' ' + requiredField + '</td>' + '<td class="formVal loadPage" page="'+loadPage+'"><label name="meta_'+labelName+'">' + labelR + '</label></td>' + '<tr>';
                            }
                        }
                        else
                        {
                            if(labelR.length==0)
                                html = '<tr>' + '<td colspan="2" class="formValFull"><label name="meta_'+labelName+'">' + XMLValue(data.label[0]) + '</label></td><tr>';
                            else
                                html = '<tr>' + '<td class="formLabel">' + labelL + ' ' + requiredField + '</td>' + '<td class="formVal"><label name="meta_'+labelName+'">' + labelR + '</label></td>' + '<tr>';
                        }
						break;
					case "text":
						//Generate input text box, with value and applied size
						var size = parseInt(XMLValue(data.size[0]));
						var dateFieldClass = "";
						var validateEmail = "";
                        var validatePass = "";
                        var inputType = "text";
						if (controlName.lastIndexOf("_date1") >= 0) {
							dateFieldClass = "futureDateField";
						} else if (controlName.lastIndexOf("_date") >= 0) {
							dateFieldClass = "dateField";
						}
						if (controlName.lastIndexOf("_email") >= 0) {
							validateEmail = " validateEmail";
						}
                        if (controlName.lastIndexOf("_password") >= 0) {
                            validatePass = " validatePass";
                            inputType = "password";
                        }
						if (size > 52) size = 52;
						html = '<tr>' + '<td class="formLabel"><label for="' + XMLValue("meta_" + data.name[0]) + '">' + XMLValue(data.label[0]) + ' ' + requiredField + '</label></td>' + '<td class="formVal"><input  type="'+inputType+'"  id="' + "meta_" + controlName + randomId + '" name="' + "meta_" + controlName + '" value="' + XMLValue(data.value[0]) + '" size="' + size + '" class="required_' + XMLValue(data.required[0]) + ' ' + dateFieldClass + validateEmail + validatePass + '" /></td>' + '<tr>';
						break;
					case "textarea":
						//Generate textarea, with value, cols provided
						var cols = parseInt(XMLValue(data.cols[0]));
						if (cols > 40) cols = 40;
						html = '<tr>' + '<td class="formLabel"><label for="' + "meta_" + controlName + '">' + XMLValue(data.label[0]) + ' ' + requiredField + '</label></td>' + '<td class="formVal"><textarea id="' + "meta_" + controlName + randomId + '" name="' + "meta_" + controlName + '" cols="' + cols + '" rows="' + XMLValue(data.rows[0]) + '" class="required_' + XMLValue(data.required[0]) + '">' + XMLValue(data.value[0]) + '</textarea></td>' + '<tr>';
						break;
					case "combo":
						//Generate dropdown list, with options provided, selected option
						var options = '';
						var opts = data.options[0].options_subitem;
						var itemCount = 0;
						for (var item in opts) {
							if (typeof opts[item] == "object" || typeof opts[item] == "string") {
								var selected = itemCount == 0 ? "selected" : "";
								var curValue = typeof opts[item] == "string" ? opts[item] : opts[item].text;
								var nameValuePair = [curValue, curValue];
								if (curValue.indexOf(":") >= 0) {
									nameValuePair = curValue.split(":");
								}
								options += '<option ' + selected + ' value="' + extractValString(nameValuePair, 1, extractValString(nameValuePair, 0)) + '">' + nameValuePair[0] + '</option>';
								itemCount++;
							}
						}
						html = '<tr>' + '<td class="formLabel"><label for="' + "meta_" + controlName + '">' + XMLValue(data.label[0]) + ' ' + requiredField + '</label></td class="formVal">' + '<td><select id="' + "meta_" + controlName + randomId + '" name="' + "meta_" + controlName + '" class="required_' + XMLValue(data.required[0]) + '">' + options + '</select></td>' + '<tr>';
						break;
					case "checkbox":
						//Generate checkboxes, with value and default selection
						var options = '';
						var opts = data.options[0].options_subitem;
						for (var item in opts) {
							if (typeof (opts[item]) != "function") {
								var selected = ""; //item == 0 ? "checked" : "";
								var nameValuePair = " : ";
								if (opts[item].text) {
									nameValuePair = opts[item].text.split(":");
								}
								options += '<span class="chkBoxPanel"><input class="chkbox required_' + XMLValue(data.required[0]) + '" type="checkbox" id="' + "meta_" + controlName + '"  ' + selected + ' name="' + "meta_" + controlName + '"  value="' + extractValString(nameValuePair, 1, extractValString(nameValuePair, 0)) + '">' + nameValuePair[0] + '</input></span>';
							}
						}
						html = '<tr>' + '<td class="formLabel"><label for="' + "meta_" + controlName + randomId + '">' + XMLValue(data.label[0]) + ' ' + requiredField + '</label></td>' + '<td class="formVal">' + options + '</td>' + '<tr>';
						break;
					case "radio":
						//Generate radio buttons, with value and default selection
						var options = '';
						var opts = data.options[0].options_subitem;
						var item = 0;
						for (var item in opts) {
							if (opts[item].text) {
								var selected = item == 0 ? "checked" : "";
								var nameValuePair = opts[item].text.split(":");
								options += '<input type="radio" id="' + "meta_" + controlName + randomId + '" ' + selected + ' name="' + "meta_" + controlName + '"  value="' + extractValString(nameValuePair, 1, extractValString(nameValuePair, 0)) + '">' + nameValuePair[0] + '</input>';
								item++;
							}
						}
						html = '<tr>' + '<td class="formLabel"><label for="' + "meta_" + controlName + '">' + XMLValue(data.label[0]) + ' ' + requiredField + '</label></td>' + '<td class="formVal">' + options + '</td>' + '<tr>';
						break;
					default:
						break;
					}
					return html; //Return current field
				}

				//Extract value from XML string
				function extractValString(item, index, rep) {
					if (item.length >= index && item[index] && item[index].toString() != "undefined") {
						return item[index];
					} else {
						return rep || "";
					}
				}

				//Get XML text from an element
				function XMLValue(val) {
					if (val && val.text) {
						return val.text;
					} else {
						return "";
					}
				}

				//Perform applet command
				function submitApplet(signed, command, destinationPath, progressBar, callback) {
					runAppletCommand(signed, "COMMAND=AUTH:::CRUSHAUTH=" + $.cookie("CrushAuth"));
					runAppletCommand(signed, command);
					if (progressBar) {
						appletProgress(progressBar, "", callback); //Update progressbar by applet progress
					}
				}

				//Listen progress of applet
				function appletProgress(progressBar, fileName, callback) {
					var operationType = "UPLOAD";
					var key = "";
					if (progressBar.attr("rel")) {
						operationType = progressBar.attr("rel");
						if (operationType == "DOWNLOAD") { //If download
							key = ":::UNIQUE_KEY=" + progressBar.parent().attr("uid");
						}
					}
					var result = runAppletCommand(true, "COMMAND=ACTION:::TYPE=" + operationType + ":::ACTION=STATUS" + key);
					var o = parseJavaProps(result);
					if(typeof o.status == "string" && o.status.length == 0)
					{
						o.status = " ";
					}
					if (!o || !o.status || o.status.toUpperCase().indexOf("CANCELLED:") == 0)
					{
						//If file upload/download is cancelled
						return;
					}
					var transferedItems = parseInt(o.transferedItems);
					var curItems = transferedItems + 1;
					var totalItems = parseInt(o.totalItems);
					if (curItems > totalItems) curItems = totalItems;
					updateProgressBar(o.transferedBytes * 1, o.totalBytes * 1, progressBar, fileName, callback, appletProgress, o.status); //Update progressbar
					if ($(progressBar).hasClass("paused") == false) {
						//If its still under progress ie. not cancelled or paused
						var $buttons = $(progressBar).parent().find(".appletActionButtons");
						$buttons.find(".filesProcessed").remove();
						var statusText = progressBar.attr("type") && progressBar.attr("type") == ("download") ? " " + getLocalizationKey("advancedOperationsDownloadStatus") : " " + getLocalizationKey("advancedOperationsUploadStatus");
						var uploadingFilesStatusText = getLocalizationKey("BrowserUploaderAdvancedUploadingFilesStatusText");
						uploadingFilesStatusText = uploadingFilesStatusText.replace("{0}", curItems);
						uploadingFilesStatusText = uploadingFilesStatusText.replace("{1}", o.totalItems);
						$buttons.prepend("<div class='filesProcessed'>" + statusText + " " + uploadingFilesStatusText + ".</div>");
						$(progressBar).after("<div class='status'>" + o.status + "</div>"); //information from the applet, current status
					}
				}

				//Submit form to the server, This is only for native file uploads
				function submitForm(uploadPopup, forms, i, auto) {
					if (forms.length > i && $(forms[i]) && $(forms[i]).attr("id")) {
						var $form = $(forms[i]);
						var filelist = uploadPopup.find("li[rel='" + $(forms[i]).attr("id") + "']");
						if (filelist.length > 0 && $form.attr("rel") != "processed") {
							//Build a progressbar and update list item
							filelist.find(".uploadCancel,.progressBar,.appletActionButtons").remove();
							filelist.find("span").replaceWith("<div class='progressBar'></div>");
							var progressBar = filelist.find("div.progressBar");
							var destinationPath = unescape(filelist.data("fileDetails").path);
							$form.find("input[name='uploadPath']").val(destinationPath);
							progressBar.progressbar({
								value: 0
							}).after("<span class='uploadCancel pointer'>" + getLocalizationKey("BrowserUploaderSelectedFileCancelLinkText") + "</span>");
							progressBar.after("<div class='uploadPath'>" + getLocalizationKey("BrowserUploaderAdvancedUploadingFilesToText") + destinationPath + "</div>");
							filelist.find(".uploadCancel").unbind().click(function () {
								$("#" + $form.attr("target")).attr("src", "javascript:false;");
								reportFileCompleted(progressBar, filelist.find("label").text(), function () {}, true);
							});
							$form.prepend($("table.customForm", "#divUploadPanel"));
							var table = $form.find("table");
							var disabled = $form.find(":disabled").removeAttr("disabled");
							$form.submit();
							disabled.attr("disabled", "disabled");
							$("#divUploadPanel").append(table);
							$form.attr("rel", "processed");
							if (!$(document).data("filesInProgress")) {
								$(document).data("filesInProgress", 0);
							}
							var filesInProgress = $(document).data("filesInProgress");
							$(document).data("filesInProgress", filesInProgress + 1);
							$("#browserFileUpload").find("h2").addClass("spinner");
							if (!$("#browserFileUpload").is(":visible")) {
								$("ul.topnav").find("a[href='javascript:browserUploader();'], a[href='javascript:performAction(\'upload\');']").addClass("bouncing_loader");
							}
							$("div.customtabs").find("a[rel='divUploadPanel']").addClass("disabledClick").addClass("padlock");
							setTimeout(function () {
								if (auto) {
									checkProgress(filelist.find("div.progressBar"), $form.find("input[type='file']").attr("name"), function () {
										startUploading(true);
									});
								} else {
									checkProgress(filelist.find("div.progressBar"), $form.find("input[type='file']").attr("name"), function () {
										submitForm(uploadPopup, forms, i + 1);
									});
								}
							}, 500);
						} else {
							submitForm(uploadPopup, forms, i + 1); //Next item to upload
						}
					} else {
						try {
							uploadsComplete();
						} catch (e) {}
						$(".refreshButton").click();
						return false;
					}
				}

				//Update progressbar based on current file upload/download progress
				function updateProgressBar(part1, part2, progressBar, fileName, callback, nextCheckFunction, status) {
					var now = new Date().getTime();
					if (!$(progressBar).data("history")) $(progressBar).data("history", new Array());
					//calculate speeds using a rolling 10 interval window.  This provides a smoother speed calculation that doesn't bounce around so much to make the user concerned
					var history = $(progressBar).data("history");//Progressbar data history
					var currentSpeed = $(progressBar).data("currentSpeed");//Current upload/download speed
					var speedHistory = $(progressBar).data("speedHistory") || [];
					/*if (history.length > 30) {
						while (history.length > 25) history.pop();
					}*/
					history.push({
						now: now,
						bytes: part1
					});
					if (history.length > 1 && $(progressBar).hasClass("paused") == false) {//Calculation and updating progressbar. Calculation of speed, percentages etc.
						var pivot = 0; //If history is for less than 5 seconds, use data of first second
						if (history.length > 5) {
							pivot = history.length - 5; // Set pivot to be of previous five second
						}
						var elapsed = now - history[0].now; // Time elapsed
						var bytes = part1 - history[pivot].bytes; // Bytes transferred in timeframe
						var lastElapsed = now - history[pivot].now;// Elapsed time for last transfer timeframe
						var originalBytes = part1 - history[0].bytes; // total bytes transferred
						var secs = ((((part2 - part1) / (originalBytes / elapsed)) / 1000) + 1) + ""; // total time remaining
						var remaining = formatTime(secs);//formatted time
						var percentDone = (part1 / part2) * 100.0;// percentages completed
						var rElapsed = formatTime((elapsed / 1000) + 1 + "");// elapsed time formatted
						var speed = "";
						var currentActualSpeed = 0;
						if ((originalBytes / elapsed) == 0) {// Still Calculating
							speed = getLocalizationKey("BrowserUploaderSpeedTimeCalculatingText");
							remaining = getLocalizationKey("BrowserUploaderSpeedTimeCalculatingText");
							$(progressBar).data("currentSpeed", speed);
						} else {
							currentActualSpeed = (bytes / lastElapsed) * 1024.0;
							speed = formatBytes(currentActualSpeed) + "/s";// Based on data transferred in last timeframe (5 secs)
							$(progressBar).data("currentSpeed", speed);
						}
						var uploadedSize = formatBytes(part1);
						var originalSize = formatBytes(part2);
						$(progressBar).data("originalSize", originalSize);
						$(progressBar).parent().find(".time,.speed,.status,.uploadStatusLabel").remove();
						$(progressBar).prepend('<span class="uploadStatusLabel">' + uploadedSize + ' of ' + originalSize + '</span>');
						var timeStampLabel = getLocalizationKey("BrowserUploaderAdvancedUploadingTimeText");
						timeStampLabel = timeStampLabel.replace("{0}", rElapsed);
						timeStampLabel = timeStampLabel.replace("{1}", remaining);
						$(progressBar).after(timeStampLabel);
						if(elapsed/1000 >= 20)
						{
							speedHistory.push(currentActualSpeed);
							$(progressBar).data("speedHistory", speedHistory);
							function getAverageSpeed()
							{
								if(speedHistory.length>30)
								{
									while (speedHistory.length > 30) speedHistory.shift();
								}
								var avgSpeed = speedHistory.average();
								if(avgSpeed>0)
								{
									return getLocalizationKey("BrowserUploaderAdvancedUploadingAverageSpeedText") + formatBytes(avgSpeed) + "/s , ";
								}
								else
									return "";
							}
							$(progressBar).after("<div class='speed'>" + getAverageSpeed() + getLocalizationKey("BrowserUploaderAdvancedUploadingSpeedText") + speed + "</div>");
						}
						else
						{
							$(progressBar).after("<div class='speed'>" + getLocalizationKey("BrowserUploaderAdvancedUploadingSpeedText") + speed + "</div>");
						}
						$(progressBar).progressbar("option", "value", percentDone);
						var type = progressBar.attr("type") || "";
						if(type != "download")
						{
							if($(progressBar).closest("#progressPanel").length == 0)
							{
								$("#progressPanel").append($(progressBar).parent());
							}
						}
					}
					if (status && status.indexOf("ERROR:") >= 0) { //If error in transmitting file
						reportFileCompleted(progressBar, fileName, callback, false, false, true, getLocalizationKey("BrowserUploaderProblemWhileTransferMsgText") +" : " + status);
						return false;
					}
					if (part1 < part2)
					{
						setTimeout(function () {//Call next function after a second
							nextCheckFunction(progressBar, fileName, callback);
						}, 1000);
					}
					else {
						if (status && status.indexOf("ERROR") >= 0) {
							//If error while upload/download
							reportFileCompleted(progressBar, fileName, callback, false, false, true, getLocalizationKey("BrowserUploaderProblemWhileTransferMsgText") + " : " + status);
						} else {
							//If file upload/download completed
							reportFileCompleted(progressBar, fileName, callback);
						}
					}
				}

				//Check progress of current file
				function checkProgress(progressBar, fileName, callback) {
					if ((progressBar.parent() && progressBar.parent().length == 0) || !progressBar.parent()) {
						return false;
					}
					//Ajax call to get update of current file
					$.ajax({
						type: "POST",
						url: o.ajaxCallURL,
						data: "command=getUploadStatus&itemName=" + crushFTPTools.encodeURILocal(fileName),
						success: function (response) {
							var responseData = response;
							if (responseData == null) responseData = "";
							responseData = getActionResponseText(responseData);
							responseData = jQuery.trim(responseData.toString());
							if (responseData.indexOf("PROGRESS:") >= 0) {
								part1 = responseData.substring("PROGRESS:".length, responseData.indexOf("/"));
								part2 = responseData.substring(responseData.indexOf("/") + 1, responseData.indexOf(";"));
								part1 = part1 * 1;
								part2 = part2 * 1;
								updateProgressBar(part1, part2, progressBar, fileName, callback, checkProgress);
							} else if (responseData.indexOf("DONE:") >= 0) {
								reportFileCompleted(progressBar, fileName, callback);
							} else if (responseData == "null" || responseData == "") { //too quick, upload hasn't started up yet.
								updateProgressBar(0, 1, progressBar, fileName, callback, checkProgress);
							} else if (responseData.indexOf("ERROR:") >= 0) {
								reportFileCompleted(progressBar, fileName, callback, false, false, true, responseData);
							} else {
								reportFileCompleted(progressBar, fileName, callback, false, false, true, "ERROR:" + responseData);
							}
						},
						complete: function (responseData) {},
						error: function (XMLHttpRequest, textStatus, errorThrown) {
							$(progressBar).parent().find(".time,.speed").remove();
							progressBar.replaceWith("[<span class='error'>"+getLocalizationKey("BrowserUploaderProblemWhileTransferMsgText")+"</span>]");
							reportFileCompleted(progressBar, fileName, callback, false, true, true);
						}
					});
				}

				//Report file completed, update all events and details of current file
				function reportFileCompleted(progressBar, fileName, callback, cancelled, wasInWaiting, error, errorMsg) {
					var wasNotInWaiting = (!wasInWaiting);
					if (!$(document).data("filesInProgress")) {
						$(document).data("filesInProgress", 0);
					}
					var filesInProgress = $(document).data("filesInProgress");
					if (filesInProgress > 0 && wasNotInWaiting) {
						$(document).data("filesInProgress", filesInProgress - 1);
					}
					if (filesInProgress == 1) {
						$("#browserFileUpload").find("h2").removeClass("spinner");
						$("ul.topnav").find("a[href='javascript:browserUploader();'], a[href='javascript:performAction(\'upload\');']").removeClass("bouncing_loader");
						$("div.customtabs").find("a[rel='divUploadPanel']").removeClass("disabledClick").removeClass("padlock");
					}
					var originalSize = $(progressBar).data("originalSize");
					originalSize = originalSize || "";
					originalSize += " ";
					var parentElm = $(progressBar).parent();
					var elapsed = progressBar.parent().find(".elapsed").text();
					parentElm.find(".uploadPath").each(function () {
						if (cancelled) { //If upload cancelled
							$(this).text($(this).text().replace(/Uploading/g, getLocalizationKey("BrowserUploaderCancelledUploadMsgText")));
							progressBar.parent().find(".time,.speed,.status").remove();
						} else if (error) { //If an error has occured
							$(this).text(errorMsg);
							$.growlUI("Error", errorMsg, o.GrowlTimeout, "growlError", o.GrowlWithCloseButton);
						} else { //else update details
							$(this).text($(this).text().replace(/Uploading/g, originalSize + "Uploaded"));
							elapsed = elapsed || "0 secs";
							$(this).append(" in " + elapsed);
						}
					});
					parentElm.find(".uploadCancel,.appletActionButtons").remove();
					if ($(progressBar).attr("rel")) { //Download
						if (cancelled) { //If download cancelled
							parentElm.prepend("[Download Cancelled] <span class='uploadCancel completed pointer'>" + getLocalizationKey("BrowserUploaderSelectedFileDismissLinkText") + "</span> ");
							parentElm.find("span.uploadCancel").wrap("<div class='appletActionButtons'></div>");
							parentElm.find("span.uploadCancel").before(" <span class='redownload pointer'>" + getLocalizationKey("BrowserUploaderSelectedFileReDownloadLinkText") + "</span> ");
							parentElm.find(".status").remove();
							$(progressBar).hide();
						} else if (error) { //If error has occured
							parentElm.prepend("Error : " + errorMsg);
							$(progressBar).hide();
							$.growlUI("Error", errorMsg, o.GrowlTimeout, "growlError", o.GrowlWithCloseButton);
						} else { //Else update details
							$(progressBar).replaceWith(getLocalizationKey("DownloadCompletedText") + " " + originalSize + getLocalizationKey("DownloadCompletedPathText") + " " + $(progressBar).attr("path") + " <span class='uploadCancel completed pointer'>" + getLocalizationKey("BrowserUploaderSelectedFileDismissLinkText") + "</span>");
							parentElm.find("span.uploadCancel").wrap("<div class='appletActionButtons'></div>").parent();
							parentElm.find("span.uploadCancel").before(" <span class='redownload pointer'>" + getLocalizationKey("BrowserUploaderSelectedFileReDownloadLinkText") + "</span> ");
							if (callback) {
								callback();
							}
						}
						//Upload cancel button event
						parentElm.find("span.uploadCancel").click(function () {
							$(this).closest("li").remove();
						});
						//re-upload/download link event
						parentElm.find("span.redownload").click(function () {
							handleFileSelectToDownload(false, false, parentElm);
						});
						parentElm.addClass("uploaded");
						parentElm.find(".speed,.remained").remove();
					} else { //Upload
						if($(progressBar).closest("#progressPanel").length>0)
						{
							$("ul.filesSelected").find('li[rel="' + $(progressBar).parent().attr("rel") + '"]').append($(progressBar).parent());
						}
						if (cancelled) {//If cancelled
							$(progressBar).parent().find(".time,.speed,.status").remove();
							$(progressBar).replaceWith("[Cancelled] <span class='uploadCancel completed pointer'>" + getLocalizationKey("BrowserUploaderSelectedFileDismissLinkText") + "</span>");
						} else if (error) {//If an error occured
							$(progressBar).replaceWith("[ERROR] <span class='uploadCancel completed pointer'>" + getLocalizationKey("BrowserUploaderSelectedFileDismissLinkText") + "</span>");
						} else {//Else update status
							$(progressBar).parent().find(".status").html("");
							$(progressBar).replaceWith("[" + getLocalizationKey("BrowserUploaderSelectedFileDoneText") + "] <span class='uploadCancel completed pointer'>" + getLocalizationKey("BrowserUploaderSelectedFileDismissLinkText") + "</span>");
						}
						parentElm.find("span.uploadCancel").wrap("<div class='appletActionButtons'></div>").parent().prepend("<span class='reupload pointer'>" + getLocalizationKey("BrowserUploaderSelectedFileReUploadLinkText") + "</span>");
						//Re-upload link event
						parentElm.find("span.reupload").click(function () {
							var listItem = $(this).closest("li");
							var itemsToReUpload = listItem.data("filesData");
							if (itemsToReUpload) {
								startUploading(true, true, itemsToReUpload, listItem); //Start upload again with items to reupload
							} else {
								$("#" + listItem.attr("rel")).removeAttr("rel");
								var dataOfFile = listItem.data("fileDetails");
								var $parentElem = listItem.parent();
								listItem.replaceWith('<li rel="' + listItem.attr("rel") + '"><label>' + dataOfFile.filename + '</label> <div class="progressPanel" rel="' + listItem.attr("rel") + '"> | ' + getLocalizationKey("BrowserUploaderSelectedFileWillBeUploadedText") + ' " ' + dataOfFile.path + '" <span>[<span class="error pointer">' + getLocalizationKey("BrowserUploaderSelectedFileRemoveLinkText") + '</span>]</span></div></li>').find("span.error").unbind().click(function () {
									$(this).closest("li").remove();
									return true;
								});
								listItem = $parentElem.find("li[rel='" + listItem.attr("rel") + "']");
								listItem.data("fileDetails", dataOfFile);
								startUploading();
							}
						});
						parentElm.find(".uploadPath").after(parentElm.find("div.appletActionButtons"));
						parentElm.find("span.uploadCancel").click(function () {
							$(this).closest("li").remove();
						});
						parentElm.addClass("uploaded");
						parentElm.find(".speed,.remained").remove();
						if (!cancelled && !error) {
							if (callback) {
								callback();
							}
						}
					}
				}

				//Format bytes to make it more readable
				function formatBytes(bytes) {
                    if(!bytes || bytes<0) return "*";
					if ((bytes / 1024).toFixed(0) == 0) return bytes.toFixed(1) + " " + getLocalizationKey("dataFormatBytes");
					else if ((bytes / 1024 / 1024).toFixed(0) == 0) return (bytes / 1024).toFixed(1) + " "  + getLocalizationKey("dataFormatKiloBytes");
					else if ((bytes / 1024 / 1024 / 1024).toFixed(0) == 0) return (bytes / 1024 / 1024).toFixed(1) + " "  + getLocalizationKey("dataFormatMegaBytes");
					else if ((bytes / 1024 / 1024 / 1024 / 1024).toFixed(0) == 0) return (bytes / 1024 / 1024 / 1024).toFixed(1) + " " + getLocalizationKey("dataFormatGigaBytes");
					else if ((bytes / 1024 / 1024 / 1024 / 1024 / 1024).toFixed(0) == 0) return (bytes / 1024 / 1024 / 1024 / 1024).toFixed(1) + " " + getLocalizationKey("dataFormatTeraBytes");
				}

				//Format time to show in upload/download progress
				function formatTime(secs) {
					var remaining = "";
					secs = secs.substring(0, secs.indexOf(".")) * 1;
					var mins = (secs / 60) + ".0";
					mins = mins.substring(0, mins.indexOf(".")) * 1;
					if (mins > 0) {
						secs -= (mins * 60);
						remaining = mins + " min, " + secs + " secs";
					} else {
						if (secs < 0) {
							remaining = getLocalizationKey("BrowserUploaderSpeedTimeCalculatingText");
						} else {
							remaining = secs + " secs";
						}
					}
					return remaining;
				}

				//Parse java properties
				function parseJavaProps(s) {
					var o = {};
					if (s) {
						var item_props = s.split(":::");
						for (var xx = 0; xx < item_props.length; xx++) {
							o[item_props[xx].substring(0, item_props[xx].indexOf("="))] = item_props[xx].substring(item_props[xx].indexOf("=") + 1); //set the key, and value on the o object
						}
					}
					return o;
				}

				//Event to finre on before unload, that will alert user if any process is running and user tries to navigate away
				window.onbeforeunload = confirmExit;

				function confirmExit() {
					//That will alert user if any process is running and user tries to navigate away
					if (!$(document).data("filesInProgress")) {
						$(document).data("filesInProgress", 0);
					}
					if ($.CrushFTP && $.CrushFTP.UploadProgressing) {
						return getLocalizationKey("BrowserUploaderAlertWhileNavigatingAwayMsgText");
					}
					var downloadFilesInProgress = $(".filesSelectedInBasket").find("div.progressBar:visible").length;
					if (downloadFilesInProgress > 0) {
						return getLocalizationKey("BrowserDownloadAlertWhileNavigatingAwayMsgText");
					}
				}

				//Method to check if file available in selected files
				function checkFileAvailalbleInSelectedList(name, _path) {
					name = name.toLowerCase();
					_path = _path.toLowerCase();
					var fileData = $("li", "ul.filesSelected");
					var fileAdded = false;
					fileData.each(function () {
						if ($(this).hasClass("groupItem")) {
							if ($(this).hasClass("uploaded") || $(this).hasClass("ignored")) return false;
							$(this).data("fileDetails", {
								filename: $(this).attr("rel"),
								path: $(this).attr("dest")
							});
							var curData = $(this).data("fileDetails");
							if (curData && curData.filename.toLowerCase() == name && curData.path.toLowerCase() == _path) {
								fileAdded = true;
							}
						} else {
							if ($(this).hasClass("uploaded") || $(this).hasClass("ignored")) return false;
							var curData = $(this).data("fileDetails");
							if (curData && curData.filename.toLowerCase() == name.toLowerCase() && curData.path.toLowerCase() == _path.toLowerCase()) {
								fileAdded = true;
							}
						}
					});
					return fileAdded;
				}

				//Get val type
				function getType(val) {
					if (val === null) return "[object Null]";
					return Object.prototype.toString.call(val);
				}

				//Handle browse complete, advanced browse
				function handleBrowseComplete(forDownload, quick) {
					var result = {};
					if (typeof window.currentApplet != "undefined") result = window.currentApplet.getASyncResult(window.command_id);
					else {
						alert(getLocalizationKey("AppletLoadingFailedMsgText"));
						return false;
					}
					if (result) {
						if (forDownload) {
							handleFileSelectToDownload(result, quick);
						} else {
							handleFileSelectToUpload(result);
						}
					} else {
						if (getType(result).toLowerCase().indexOf("string") < 0) {
							setTimeout(function () {
								handleBrowseComplete(forDownload, quick);
							}, 200);
						} else {
							if (quick) {
								$(document).data(o.BasketDataKeyQuickDownload, new Array());
							}
						}
					}
				}

				//File selected to download
				function handleFileSelectToDownload(result, quick, progressBar) {
					bindUserName(false, function (response, username) {
						if (response == "failure") {
							window.location = window.location;
						} else {
							var itemList = [];
							var stringToCopy = "";
							var downloadList = [];
							var downloadInfo = {};
							if (!progressBar) {
								result = result + ""; //need to conver this JavaRuntimeObject to a String
								var destinationPath = hashListener.getHash().toString().replace("#", "") || "/";
								itemList = parseJavaProps(result.split(";;;")[0]);
								itemList.destinationPath = destinationPath;
								var targetUrl = unescape(window.location.toString()).replace(unescape(hashListener.getHash().toString()), "");
								if (!$(document).data(o.BasketDataKey)) {
									$(document).data(o.BasketDataKey, new Array());
								}
								var uniqueId = generateRandomPassword(10);
								var ItemsInTheBasket = $(document).data(o.BasketDataKey);
								if (quick) {
									ItemsInTheBasket = $(document).data(o.BasketDataKeyQuickDownload);
								}
								for (var i = 0; i < ItemsInTheBasket.length; i++) {
									var fileName = crushFTPTools.decodeURILocal(unescape(ItemsInTheBasket[i].file));
									fileName = fileName.toString();
									fileName = fileName.replace("//","/");
									var j = i + 1;
									stringToCopy += "P" + j + "=" + fileName + ":::";
								};
								if (quick) {
									$(document).data(o.BasketDataKeyQuickDownload, new Array());
								} else {
									$(document).data(o.BasketDataKey, new Array());
								}
								rebuildBasket("");
								if (stringToCopy.length > 0) {
									stringToCopy = stringToCopy.substring(0, stringToCopy.length - 3);
								}
								progressBar = $("<li style='list-style:none;' uid='" + uniqueId + "'><div class='progressBar'></div></li>");
								$(".filesSelectedInBasket").prepend(progressBar);
								$(".filesSelectedInBasket").find("li:not(li[uid])").remove();
								progressBar = progressBar.find("div");
								progressBar.attr("type", "download");
								progressBar.parent().data("downloadList", stringToCopy);
								progressBar.parent().data("currentDownloadList", ItemsInTheBasket);
								progressBar.parent().data("progressBar", progressBar);
								downloadInfo = {
									targetUrl: targetUrl,
									path: itemList.path,
									downloadFiles: stringToCopy,
									uniqueId: uniqueId,
									destinationPath: itemList.destinationPath
								}
								progressBar.parent().data("downloadInfo", downloadInfo);
							} else {
								downloadList = progressBar.data("downloadList");
								downloadInfo = progressBar.data("downloadInfo");
								var progressBarHTML = progressBar.data("progressBar");
								progressBar.empty().append(progressBarHTML);
								progressBar.removeClass("uploaded");
								progressBar = progressBar.find("div.progressBar").show();
								progressBar.find(".ui-progressbar-value").remove();
							}
							progressBar.before("<div class='appletActionButtons'><span class='pause pointer'>" + getLocalizationKey("BrowserUploaderSelectedFilePauseLinkText") + "</span> <span class='uploadCancel stop pointer'>" + getLocalizationKey("BrowserUploaderSelectedFileCancelLinkText") + "</span></div>");
							progressBar.parent().find(".uploadCancel").unbind().click(function () {
								runAppletCommand(true, "COMMAND=ACTION:::TYPE=DOWNLOAD:::ACTION=CANCEL:::UNIQUE_KEY=" + downloadInfo.uniqueId);
								var curElm = $(this);
								reportFileCompleted(progressBar, downloadInfo.path, false, true);
								curElm.blur();
							});
							progressBar.parent().find(".pause").unbind().click(function () {
								var curElm = $(this);
								if (curElm.hasClass("pause")) {
									runAppletCommand(true, "COMMAND=ACTION:::TYPE=DOWNLOAD:::ACTION=PAUSE:::UNIQUE_KEY=" + downloadInfo.uniqueId);
									curElm.removeClass("pause").addClass("resume").html(getLocalizationKey("BrowserUploaderSelectedFileResumeLinkText"));
									progressBar.parent().find(".time,.speed").remove();
									progressBar.parent().find(".uploadPath").hide();
									progressBar.addClass("paused").parent().find(".status").html(getLocalizationKey("BrowserUploaderSelectedFilePausedStatusText"));
								} else if (curElm.hasClass("resume")) {
									runAppletCommand(true, "COMMAND=ACTION:::TYPE=DOWNLOAD:::ACTION=RESUME:::UNIQUE_KEY=" + downloadInfo.uniqueId);
									curElm.removeClass("resume").addClass("pause").html(getLocalizationKey("BrowserUploaderSelectedFilePauseLinkText"));
									progressBar.parent().find(".uploadPath").show();
									progressBar.parent().find(".status").html("Resuming...");
									progressBar.removeClass("paused");
								}
								curElm.blur();
							});
							runAppletCommand(true, "COMMAND=AUTH:::CRUSHAUTH=" + $.cookie("CrushAuth"));
							progressBar.progressbar({
								value: 0
							}).attr("rel", "DOWNLOAD").attr("path", downloadInfo.path);
							$("#submitActionBasket").find(".clearCompleted").hide();
							var resumeUpload = ":::RESUME=" + $("#chkDownloadResume").is(":checked");
							var compressionUpload = ":::NOCOMPRESSION=" + ($.cookie(o.CookieNoCompressionFlag) == "true");
                            if(typeof window.compressionInApplet != "undefined")
                                compressionUpload = ":::NOCOMPRESSION=" + (window.compressionInApplet != "true");
                            var cmd = "COMMAND=DOWNLOAD:::URL=" + downloadInfo.targetUrl + ":::PATH=" + downloadInfo.path + ":::" + downloadInfo.downloadFiles + resumeUpload + compressionUpload + ":::UNIQUE_KEY=" + downloadInfo.uniqueId;
                            if(window.DOWNLOAD_THREADS)
                                cmd += ":::DOWNLOAD_THREADS=" + window.DOWNLOAD_THREADS;
							submitApplet(true, cmd, downloadInfo.destinationPath, progressBar, function () {
								$("#submitActionBasket").find(".clearCompleted").show();
							});
						}
					});
				}

				//Get x position of an element
				function getX(oElement) {
					var iReturnValue = 0;
					while (oElement != null) {
						iReturnValue += oElement.offsetLeft;
						oElement = oElement.offsetParent;
					}
					return iReturnValue;
				}

				//Get y position of an element
				function getY(oElement) {
					var iReturnValue = 0;
					while (oElement != null) {
						iReturnValue += oElement.offsetTop;
						oElement = oElement.offsetParent;
					}
					return iReturnValue;
				}

				//Handle applet browse, open browse window
				function handleAppletBrowse(forDownload, quick) {
					if (forDownload) {
						runAppletCommand(true, "COMMAND=AUTH:::CRUSHAUTH=" + $.cookie("CrushAuth"));
						window.command_id = runAppletCommand(true, "COMMAND=BROWSE:::DIRECTORIES_ONLY=true:::TITLE=" + getLocalizationKey("advancedDownloadPathSelectionWindowTitle"), true);
					} else {
						window.command_id = runAppletCommand(true, "COMMAND=BROWSE:::TITLE=" + getLocalizationKey("advancedUploadItemsSelectionWindowTitle"), true);
					}
					handleBrowseComplete(forDownload, quick);
				}

				//Run applet command
				window.runAppletCommand = function(signed, command, async) {
					try {
						if (async) {
							return window["currentApplet"+ (signed ? "" : "U")].doCommandASync(command) + "";
						} else {
							return window["currentApplet"+ (signed ? "" : "U")].doCommandSync(command) + ""; //     +""     is needed to convert form the Java object type to a JavaScript string type
						}
					} catch (e) {}
				}

				//Load applet on page, allows callback when applet is ready
				window.loadApplet = function(signed, callback, noNote) {
					if (!navigator.javaEnabled()) {
						$.growlUI(getLocalizationKey("JavaRequiredGrowlText"), getLocalizationKey("JavaRequiredDescGrowlText"), o.GrowlTimeout, "growlError", o.GrowlWithCloseButton);
                        if(callback)
                            callback(false);
						return;
					}
                    var loadingIndicator = $("#loadingIndicator");
                    loadingIndicator.dialog('open');
                    var iframeID = "javaAppletIframe"+ (signed ? "" : "U");
					var s = "<div id='dragdropAppletDiv' style='background-color:#F0F7CD;margin:0px;'><div><div class='appletNote'>"+localizations.appletUploaderDropPanelLabelText+"</div>" + "<iframe style='padding:0px;margin:0px;' frameborder='0' scrolling='no' width='100%' height='50' id='"+iframeID+"' src='/WebInterface/jQuery/applet"+(signed ? "" : "U")+".html'></iframe></div></div>";
					if (signed) {
                        $("#javaAppletDiv").css({
                        "right" : "0px",
                        "left" : "auto"}).css("z-index", "1002");
						$("div#browserFileUpload").find(".advancedBrowse").before("<span class='spinner' style='display:inline-block;padding-left:18px;float:right;margin: 7px 0px 0px 10px;'>Loading...</span>");
						$("div#submitActionBasket").find(".advanced").addClass("spinner").addClass("spinnerAdvanced");
					}
                    setTimeout(function () {
                        var pnl = $("#javaAppletDiv" + (signed ? "" : "U")).html(s);
                        $("#"+iframeID).load(function(){
                            if(noNote)
                                pnl.find(".appletNote").hide();
    						isAppletReady(signed, function(failed){
                                loadingIndicator.dialog('close');
                                if(failed)
                                {
                                    $.growlUI(getLocalizationKey("JavaLoadingProblemGrowlText"), getLocalizationKey("JavaLoadingProblemDescGrowlText"), o.GrowlTimeout, "growlError", o.GrowlWithCloseButton);
                                    if(callback)
                                        callback();
                                }
                                else
                                {
                                    if(callback)
                                        callback(pnl);
                                    if (navigator.appName.indexOf("Explorer") >= 0) return false;
                                        $("#javaAppletDiv").css("left", "-5000px").css("z-index", "1001");
                                }
                            });
                        }).error(function(){
                            loadingIndicator.dialog('close');
                            $.growlUI(getLocalizationKey("JavaLoadingProblemGrowlText"), getLocalizationKey("JavaLoadingProblemDescGrowlText"), o.GrowlTimeout, "growlError", o.GrowlWithCloseButton);
                            if(callback)
                                callback();
                        });
					}, 100);
				}

				//Method to check if applet is ready
				function isAppletReady(signed, callback) {
					try
					{
                        var iframeID = "javaAppletIframe"+ (signed ? "" : "U");
                        window.appletTries = window.appletTries || 0;
                        var appletItem = $("#" + iframeID).contents().find("#javaApplet" + (signed ? "" : "U")).get(0);
                        window["currentApplet"+ (signed ? "" : "U")] = appletItem;
						if (appletItem && appletItem.test() == "OK")
						{
							$(document).data("appletLoaded" + (signed ? "" : "U"), true);
							if (signed) {
								$("div#browserFileUpload").find(".advancedBrowse").prev().remove();
								$("div#submitActionBasket").find(".advanced").removeClass("spinner").removeClass("spinnerAdvanced");
								$("#advancedBrowseOptions").show(1000);
							}
							runAppletCommand(signed, "COMMAND=AUTH:::CRUSHAUTH=" + $.cookie("CrushAuth"));
							if (callback)
							{
								callback();
							}
						}
						else
						{
							setTimeout(function () {
                                window.appletTries += 1;
								isAppletReady(signed, callback);
							}, 100);
						}
					}
					catch (e) {
						setTimeout(function () {
                            window.appletTries += 1;
                            if(window.appletTries==10)
                            {
                                delete window.appletTries;
                                callback(true);
                            }
                            else
                                isAppletReady(signed, callback);
						}, 1000);
					}
				}

				//Load popup content, binds various events
				function loadPopupContent() { /* Data to POST to receive file listing */
					$("#popupContent").find("input#txtNewFolder").keyup(function (evt) {
						var evt = (evt) ? evt : ((event) ? event : null);
						if (evt.keyCode == 13) {
							makedir();
							return false;
						} else if (evt.keyCode == 27) {
							$.unblockUI();
							return false;
						}
					});
					var varHideItemsStartingWithDot = $.cookie(o.CookieHideItemStartingWithDot);
					varHideItemsStartingWithDot = varHideItemsStartingWithDot == "true";
					if (varHideItemsStartingWithDot) {
						$("#hideItemsStartingWithDot").attr("checked", "checked");
					} else {
						$("#hideItemsStartingWithDot").removeAttr("checked");
					}
					var varHideCheckBoxColumn = $.cookie(o.CookieHideCheckBoxColumn);
					varHideCheckBoxColumn = varHideCheckBoxColumn == "true";
					if (varHideCheckBoxColumn) {
						$("#hideCheckBoxColumn").attr("checked", "checked");
					} else {
						$("#hideCheckBoxColumn").removeAttr("checked");
					}
					var varHideFilter = $.cookie(o.CookieHideFilter);
					varHideFilter = varHideFilter == "true";
					if (varHideFilter) {
						$("#hideFilter").attr("checked", "checked");
					} else {
						$("#hideFilter").removeAttr("checked");
					}
					if ($.cookie(o.CookieAutoUploadFlag) + "" == "true") {
						$("#autoUploadFlag").attr("checked", "checked");
					} else {
						$("#autoUploadFlag").removeAttr("checked");
					}
					if ($.cookie(o.CookieAutoAppletFlag) + "" == "true") {
						$("#autoAppletFlag").attr("checked", "checked");
					} else {
						$("#autoAppletFlag").removeAttr("checked");
					}
					if ($.cookie(o.CookieNoCompressionFlag) + "" == "true") {
						$("#noCompressionFlag").attr("checked", "checked");
					} else {
						$("#noCompressionFlag").removeAttr("checked");
					}
					initTabs();
					$("#shareOptionDiv").data("html", $("#shareOptionDiv").html());
				}

				//Block/unblock file listing UI
				function blockFileListingUI(flag) {
					if (flag) {
						$(".mainProcessIndicator").show();
					} else {
						$(".mainProcessIndicator").fadeOut(500);
					}
				}

				//Toggle checkboxes
				function toggleCheckBoxes(el, val) {
					if (val == 1) {
						var chkBox = $(el);
						chkBox.attr("checked", "checked");
						toggleCheckBoxesAll($(el).closest("table"), chkBox.is(":checked"));
						toggleMainCheckbox(chkBox.closest("table"));
					} else if (val == 0) {
						var chkBox = $(el);
						chkBox.removeAttr("checked");
						toggleCheckBoxesAll($(el).closest("table"), chkBox.is(":checked"));
						toggleMainCheckbox(chkBox.closest("table"));
					} else {
						var chkBox = $(el);
						chkBox.removeAttr("checked");
						toggleCheckBoxesAll($(el).closest("table"), chkBox.is(":checked"), true);
						toggleMainCheckbox(chkBox.closest("table"));
					}
				}

				//Toggle all checkboxes
				function toggleCheckBoxesAll(elem, status, toggle) {
					var infoBar = $("#selectionOfItemsOptions").hide();
					checkUnCheckDirectory(
					$(elem).find("TR.jqueryFileTree"), status, true, toggle);
					if (status) {
						showSelectionInfoBar();
					} else {
						window.listingInfo.selectedEverything = false;
					}
				}

				//Show selection info bar. It will be shown when all items in listing are selected and there are more hidden in paging
				function showSelectionInfoBar() {
					var totalCheckedItems = $("TR.jqueryFileTree").find(".chkBox:visible:checked").length;
					if (currentView() == "Thumbnail") {
						totalCheckedItems = $("#filesContainerDiv").find("li.fileBoxSelected:visible").length;
					}
					if ((window.listingInfo.filtered && totalCheckedItems < window.matchedItems.length) || (!window.listingInfo.filtered && totalCheckedItems < window.listingInfo.totalItemsInDir)) { //If all items listed are selected and there are more hidden in paging
						var infoBar = $("#selectionOfItemsOptions").show();
						var listType = getLocalizationKey('ItemsSelectionShowingFolderText');
						if (window.listingInfo.filtered) {
							listType = getLocalizationKey('ItemsSelectionShowingFilteredItemsText');
						} else if (window.listingInfo.isSearchResult) {
							listType = getLocalizationKey('ItemsSelectionShowingSearchedItemsText');
						}
						if (window.listingInfo.selectedEverything) {
							infoBar.find(".options").hide();
							infoBar.find(".actions").show();
							var allItemSelectedText = getLocalizationKey('ItemsSelectionSelectedAllItemsInDir');
							if (window.listingInfo.filtered) {
								allItemSelectedText = allItemSelectedText.replace('{total_items}', window.matchedItems.length);
							} else {
								allItemSelectedText = allItemSelectedText.replace('{total_items}', window.listingInfo.totalItemsInDir);
							}
							allItemSelectedText = allItemSelectedText.replace('{list_type}', listType);
							infoBar.find("#ItemsSelectionSelectedAllItemsInDir").html(allItemSelectedText);
						} else {
							infoBar.find(".options").show();
							infoBar.find(".actions").hide();
							infoBar.find("#ItemsSelectionDisplayText").html(getLocalizationKey('ItemsSelectionDisplayText').replace('{count}', totalCheckedItems));
							var allItemSelectText = getLocalizationKey('ItemsSelectionSelectAllItemsInDir');
							if (window.listingInfo.filtered) {
								allItemSelectText = allItemSelectText.replace('{total_items}', window.matchedItems.length);
							} else {
								allItemSelectText = allItemSelectText.replace('{total_items}', window.listingInfo.totalItemsInDir);
							}
							allItemSelectText = allItemSelectText.replace('{list_type}', listType);
							infoBar.find("#ItemsSelectionSelectAllItemsInDir").html(allItemSelectText);
						}
					}
				}

				//Select/Deselect all items
				function selectDeselectAllItems(flag, toggle, basket) {
					if (currentView(basket) != "Thumbnail") {
						var tbl = $("#filesListing").find("table");
						if(basket)
							tbl = $("#FileBasketList").find("table");
						toggleCheckBoxesAll(tbl, flag, toggle);
						toggleMainCheckbox(tbl, flag, toggle);
					} else {
						var container = $("#filesContainerDiv");
						if(basket)
							container = $("#FileBasketList");
						if (toggle) {
							container.find("li:visible").each(function () {
								if ($(this).hasClass("fileBoxSelected")) {
									$(this).removeClass("fileBoxSelected");
								} else {
									$(this).addClass("fileBoxSelected");
								}
							});
						} else {
							if (flag) {
								container.find("li:visible").addClass("fileBoxSelected");
								if(!basket)
									showSelectionInfoBar();
							} else {
								container.find("li.fileBoxSelected:visible").removeClass("fileBoxSelected");
								if(!basket)
								{
									window.listingInfo.selectedEverything = false;
									$("#selectionOfItemsOptions").hide();
								}
							}
						}
					}
				}

				//Is all checkboxes in element are selected
				function isChecked(elem) {
					var allChecked = true;
					$(elem).find("TR.jqueryFileTree:visible").each(function () {
						if (!$(this).find("input.chkBox:visible").is(":checked")) {
							allChecked = false;
						}
					});
					return allChecked;
				}

				//Toggle main checkbox, check all
				function toggleMainCheckbox(elem, status) {
					status = status || isChecked(elem);
					if (status) {
						$(elem).find("input.chkBoxAll").attr("checked", "checked");
					} else {
						$(elem).find("input.chkBoxAll").removeAttr("checked");
					}
				}

				//Check/uncheck directory based on files beneath directory
				function checkUnCheckDirectory(trElems, check, rootDir, toggle) {
					$(trElems).each(function () {
						if (rootDir) {
							$(this).find("td.directory").each(function () {
								checkUnCheckDirectory(
								$(this).closest("table").find('TR[rel="' + $(this).find('a').attr('rel') + '"]').find(".chkBox:visible").parent(), check, undefined, toggle);
							});
						} else {
							$(this).parent().find("td.directory").each(
							function () {
								checkUnCheckDirectory(
								$(this).closest("table").find('TR[rel="' + $(this).find('a').attr('rel') + '"]').find(".chkBox:visible").parent(), check, undefined, toggle);
							});
						}
						if (toggle) {
							var checkedElems = $(this).find(".chkBox:visible:checked");
							var unCheckedElems = $(this).find(".chkBox:visible").not(":checked");
							checkedElems.removeAttr("checked");
							unCheckedElems.attr("checked", "checked");
						} else {
							if (check) {
								$(this).find(".chkBox:visible").attr("checked", "checked");
							} else {
								$(this).find(".chkBox:visible").removeAttr("checked");
							}
						}
					});
				}

				//Current view
				function currentView(basket) {
					basket = basket ? "_basket" : "";
					if (!$("body").data("currentView" + basket)) {
						var currentViewType = $.cookie(o.ViewCookieName + basket);
						if (currentViewType && currentViewType == "Thumbnail") {
							$("body").data("currentView" + basket, currentViewType);
						} else {
							$("body").data("currentView" + basket, "Tree");
						}
					}
					return $("body").data("currentView" + basket);
				}

				//Method to change current view, refresh after changing view
				function changeView(type, refresh, basket) {
					var _basket = basket ? "_basket" : "";
					if(basket)
					{
						$("body").data("currentView" + _basket, type);
						var options = {
							path: '/',
							expires: 10
						};
						$.cookie(o.ViewCookieName + _basket, type, options);
						if (type == "Thumbnail") {
							$("#sliderBasket").show();
						} else {
							$("#sliderBasket").hide();
						}
						if($("div#filesBasket").dialog("isOpen"))
							rebuildBasket(false);
					}
					else
					{
						if (!window.listingInfo.selectedEverything) $("#selectionOfItemsOptions").hide();
						$("body").data("currentView", type);
						var options = {
							path: '/',
							expires: 10
						};
						$.cookie(o.ViewCookieName, type, options);
						if (type == "Thumbnail") {
							$("#filesContainer").hide();
							$("#filesContainerDiv").show();
							$("#slider").show();
						} else {
							$("#filesContainerDiv").hide();
							$("#filesContainer").show();
							$("#slider").hide();
						}

						if (refresh) {
							blockFileListingUI(true);
							if ($(document).data("searchData")) {
								if (currentView() == "Thumbnail") {
									renderListing($("#filesContainerDiv"), false, false, $(document).data("searchData"), true);
								} else {
									renderListing($("#filesContainer"), false, false, $(document).data("searchData"), true);
								}
							} else {
								if (type == "Thumbnail") {
									showTree($("#filesContainerDiv"), "", true, true);
								} else {
									showTree($("#filesContainer"), "", true, true);
								}
							}
						}
					}
				}

				//Map XML to tables, converts XML to an array/json
				function mapXmlToTable(data, table, disablePrivsSet, folderExpand) {
                    if(!data)return;
                    var msg = data.listing;
					if (msg) {
						if (folderExpand) window.curTreeItems = window.curTreeItems ? window.curTreeItems : {};
						else window.curTreeItems = window.curTreeItems ? window.curTreeItems : window.l ? window.l : {};
                        if (!disablePrivsSet) {
                            $(document).data("folderPrivs", data.privs);
						}
						if (folderExpand) {
							if (l && l.length > 0) {
								var rel = folderExpand.find("a").attr("rel");
								for (var i = 0; i < curTreeItems.length; i++) {
									var curItem = curTreeItems[i];
									if (curItem.root_dir + unescape(curItem.name) + "/" == unescape(rel)) {
										for (var j = l.length - 1; j >= 0; j--) {
											var subItem = l[j];
											subItem.ItemType = "subDir";
											curTreeItems.splice(i + 1, 0, subItem);
										}
										i = curTreeItems.length;
									}
								}
							}
							return generateListing(curTreeItems);
						} else {
							curTreeItems = l;
							return generateListing();
						}
					} else {
						$(document).data("folderPrivs", false);
						l = [];
						return "";
					}
				}

				//Filter listed item quickly as user types
				function filterItem(phrase, forced) {
					if (window.last_search_item && window.last_search_item === phrase && !forced) {
						return false;
					}
					window.last_search_item = phrase || window.last_search_item;
					if(forced)
					{
						$("#filter").val(window.last_search_item);
					}
					if($.trim(phrase) == "")
					{
						window.last_search_item = "";
						window.filteredItems = false;
						window.matchedItems = false;
						window.listingInfo.selectedEverything = false;
						reBuildListing(l);
						bindCountOfFiles();
						$.unblockUI();
						return false;
					}
					var files = 0;
					var dirs = 0;
					var curListItems = l;
					if (currentView() != "Thumbnail") {
						curListItems = window.curTreeItems;
					}
					var matchedItems = [];
					var hasWords = function (str, words, exclude) {
						if (!str || !words || str.length == 0 || words.length == 0) return false;
						var text = str.toLowerCase();
						for (var i = 0; i < words.length; i++) {
                            if(exclude)
                            {
                                if (text.indexOf(words[i]) !== -1) return false;
                            }
                            else
                            {
                                if (text.indexOf(words[i]) === -1) return false;
                            }
						}
						return true;
					}
					var regex = false;
                    var exclude = phrase.indexOf("!") == 0;
                    if(exclude)
                        phrase = phrase.substr(1, phrase.length);
                    if(phrase && phrase.toLowerCase().indexOf("regex:")==0)
                    {
                        try{
                            regex = new RegExp(phrase.substr(phrase.indexOf(":")+1, phrase.length), "i");
                        }catch(ex){
                            regex = false;
                        }
                    }
					if (curListItems && curListItems.length > 0) {
						for (var i = 0; i <= curListItems.length; i++) {
							var opt = curListItems[i];
							if (opt) {
								if (currentView() == "Thumbnail") {
									var words = phrase.toLowerCase().split(" ");
									if(regex)
									{
										if(regex.test(opt.name))
										{
											matchedItems.push(opt);
											if (opt.type == "FILE") {
												files += 1;
											} else {
												dirs += 1;
											}
										}
									}
									else
									{
										if (hasWords(opt.name, words, exclude)) {
											matchedItems.push(opt);
											if (opt.type == "FILE") {
												files += 1;
											} else {
												dirs += 1;
											}
										}
									}
								} else {
									var words = phrase.toLowerCase().split(" ");
									if(regex)
									{
										if(regex.test(opt.name) || regex.test(opt.keywords))
										{
											matchedItems.push(opt);
											if (opt.type == "FILE") {
												files += 1;
											} else {
												dirs += 1;
											}
										}
									}
									else
									{
										if (hasWords(opt.name, words, exclude)) {
											matchedItems.push(opt);
											if (opt.type == "FILE") {
												files += 1;
											} else {
												dirs += 1;
											}
										} else if (hasWords(opt.keywords, words, exclude)) {
											matchedItems.push(opt);
											if (opt.type == "FILE") {
												files += 1;
											} else {
												dirs += 1;
											}
										}
									}
								}
							}
						}
					}
					window.current_page = o.pagingCurrentPage = 0;
					if (phrase.length > 0) {
						window.filteredItems = {
							filesCount: files,
							dirsCount: dirs
						};
					} else {
						window.filteredItems = false;
						$("#selectionOfItemsOptions").hide();
					}
					window.matchedItems = matchedItems;
					window.listingInfo.selectedEverything = false;
					reBuildListing(window.matchedItems); //rebuild listing with filtered items
					bindCountOfFiles();
					$.unblockUI();
				}

				//Filter listed item quickly as user types in basket
				function filterBasketItem(phrase, forced) {
					if (window.last_search_item_basket && window.last_search_item_basket === phrase && !forced) {
						return false;
					}
					window.last_search_item_basket = phrase || window.last_search_item_basket;
					if(forced)
					{
						$("#filterBasket").val(window.last_search_item_basket);
					}
					var files = 0;
					var dirs = 0;
					if (!$(document).data(o.BasketDataKey)) {
						$(document).data(o.BasketDataKey, new Array());
					}
					//Items in the basket
					var curListItems = $(document).data(o.BasketDataKey);
					if($.trim(phrase) == "")
					{
						window.last_search_item_basket = "";
						if (curListItems && curListItems.length > 0) {
							for (var i = 0; i <= curListItems.length; i++) {
								var opt = curListItems[i];
								if (opt) {
									delete opt.hide;
								}
							}
						}
						$(document).data(o.BasketDataKey, curListItems);
						window.filteredItemsBasket = false;
						rebuildBasket();
						return false;
					}
                    var hasWords = function (str, words, exclude) {
                        if (!str || !words || str.length == 0 || words.length == 0) return false;
                        var text = str.toLowerCase();
                        for (var i = 0; i < words.length; i++) {
                            if(exclude)
                            {
                                if (text.indexOf(words[i]) !== -1) return false;
                            }
                            else
                            {
                                if (text.indexOf(words[i]) === -1) return false;
                            }
                        }
                        return true;
                    }
                    var regex = false;
                    var exclude = phrase.indexOf("!") == 0;
                    if(exclude)
                        phrase = phrase.substr(1, phrase.length);
					if(phrase && phrase.toLowerCase().indexOf("regex:")==0)
					{
						try{
							regex = new RegExp(phrase.substr(phrase.indexOf(":")+1, phrase.length), "i");
						}catch(ex){
							regex = false;
						}
					}
					if (curListItems && curListItems.length > 0) {
						for (var i = 0; i <= curListItems.length; i++) {
							var opt = curListItems[i];
							if (opt) {
								delete opt.hide;
								if (currentView(true) == "Thumbnail") {
									var words = phrase.toLowerCase().split(" ");
									if(regex)
									{
										if(regex.test(opt.name))
										{
											opt.hide = true;
											if (opt.type == "FILE") {
												files += 1;
											} else {
												dirs += 1;
											}
										}
									}
									else
									{
										if (hasWords(opt.name, words, exclude)) {
											opt.hide = true;
											if (opt.type == "FILE") {
												files += 1;
											} else {
												dirs += 1;
											}
										}
									}
								} else {
									var words = phrase.toLowerCase().split(" ");
									if(regex)
									{
										if(regex.test(opt.name) || regex.test(opt.keywords))
										{
											opt.hide = true;
											if (opt.type == "FILE") {
												files += 1;
											} else {
												dirs += 1;
											}
										}
									}
									else
									{
										if (hasWords(opt.name, words, exclude)) {
											opt.hide = true;
											if (opt.type == "FILE") {
												files += 1;
											} else {
												dirs += 1;
											}
										} else if (hasWords(opt.keywords, words, exclude)) {
											opt.hide = true;
											if (opt.type == "FILE") {
												files += 1;
											} else {
												dirs += 1;
											}
										}
									}
								}
							}
						}
					}
					if (phrase.length > 0) {
						window.filteredItemsBasket = {
							filesCount: files,
							dirsCount: dirs
						};
						$(document).data(o.BasketDataKey, curListItems);
					} else {
						window.filteredItemsBasket = false;
					}
					rebuildBasket(); //rebuild listing with filtered items
					bindCountOfFiles(true);
				}

				//Generate listing based on custom items
				function generateListing(customItem) {
                    if(!window.l || window.listingPageShown) return "";
					var curDirItems = customItem ? customItem : l;
					if (currentView() != "Thumbnail") {
						curDirItems = customItem ? customItem : window.curTreeItems;
					}
					var CookiePageSize = getPageSize();
					var currentPage = o.pagingCurrentPage;
					var cookiePageSizeIsValid = (CookiePageSize - 0) == CookiePageSize && CookiePageSize.length > 0;
					if (curDirItems && curDirItems.length > 0) {
						var fileList = [];
						var maxEntries = curDirItems.length;
						var start = 0;
						if (cookiePageSizeIsValid) {
							CookiePageSize -= 1;
							var page = currentPage == 0 ? 0 : currentPage;
							if (page > 0) {
								maxEntries = CookiePageSize * (page + 1);
								start = CookiePageSize * page;
								start += page;
								maxEntries += page;
							} else {
								maxEntries = CookiePageSize;
							}
						}
						//Loop through items and build HTML for thumbs and tree view
                        var linkURL = unescape(window.location.href.split('#')[0]);
                        linkURL = linkURL.substring(0, linkURL.lastIndexOf("/"));
						for (var i = start; i <= maxEntries; i++) {
							var x = i;
							var opt = curDirItems[i];
							if (opt) {
                                if(typeof window.listingHTMLPage != "undefined" && window.listingHTMLPage.toLowerCase() == opt.name.toLowerCase())
                                {
                                    replaceFileExist = true;
                                    i = maxEntries +1;
                                }
								var keywords = unescape(opt.keywords);
								if (keywords.length >= o.keywordsCharLimit) {
									keywords = keywords.substr(
									0, o.keywordsCharLimit) + "...";
								}
                                var syncedItemClass = (opt.privs && opt.privs.indexOf("syncName=")!=-1) ? "syncItem" : "";
                                if (currentView() == "Thumbnail") {
                                    var fileName = crushFTPTools.htmlEncode(opt.name, false, true);
                                    if (opt.type === 'DIR') {
                                        if(window.maskedEmptyFolder)
                                        {
                                            if(opt.size + "" == "0")
                                                syncedItemClass += " emptyFolder ";
                                        }
                                        var downloadURL = "draggable=\"true\" data-downloadurl=\"application/octet-stream:" + fileName + ".zip:" +linkURL+'?command=downloadAsZip&zipName='+fileName+'.zip&path='+crushFTPTools.htmlEncode(opt.href_path, false, true) + '&paths='+crushFTPTools.htmlEncode(opt.href_path, false, true)+"\"";
                                        var dirTemplate = '<li '+downloadURL+' root_dir="' + opt.root_dir + '" class="vtip '+syncedItemClass+' fileBox directoryThumb" index="' + x + '" name="' + opt.name + '" title="<div class=\'tooltip-content\'><strong>' + getLocalizationKey('TooltipNameLabelText') + ' : </strong>' + opt.name + '<br /><strong>' + getLocalizationKey('TooltipModifiedLabelText') + ' : </strong>' + opt.dateFormatted + '<br /><strong>' + getLocalizationKey('TooltipKeywordsLabelText') + ' : </strong>' + keywords + '</div>" privs="' + escape(opt.privs) + '" sizeInBytes="' + opt.size + '" size="' + opt.sizeFormatted + '" fulldate="' + opt.modified + '" Date="' + opt.dateFormatted + '" Keywords="' + crushFTPTools.xmlEncode(keywords) + '" preview="' + opt.preview + '"><span class="fileSelectionMark"></span><div>' + '<div class="imgBox"><div class="imgWrapper">' + '<table cellspacing="0" cellpadding="0" align="center">' + '<tbody>' + '<tr>' + '<td valign="middle" align="center">' + '<a class="imgLink" rel="' + escape(unescape(opt.href_path)) + "/" + '" href="' + crushFTPTools.htmlEncode(opt.href_path, false, true) + '">' + '<img alt="' + opt.name + '" title="' + opt.name + '" style="border: 0px none;" src="' + o.spinerImage + '">' + '</a>' + '</td>' + '</tr>' + '</tbody>' + '</table></div>' + '</div>' + '</div>' + '<div class="imgTitle">' + '<a  rel="' + opt.root_dir + '" href="' + opt.href_path + '">' + crushFTPTools.htmlEncode(opt.name, false, true) + '</a>' + '</div>' + '</li>';
                                        fileList.push(dirTemplate);
                                    } else if (opt.type === 'FILE') {
                                        var downloadURL = "draggable=\"true\" data-downloadurl=\"application/octet-stream:" + fileName + ":" +linkURL+crushFTPTools.htmlEncode(opt.href_path, false, true)+"\"";
                                        var fileTemplate = '<li '+downloadURL+' root_dir="' + opt.root_dir + '" class="vtip '+syncedItemClass+' fileBox fileThumb" index="' + x + '" name="' + opt.name + '" title="<div class=\'tooltip-content\'><strong>' + getLocalizationKey('TooltipNameLabelText') + ' : </strong>' + opt.name + '<br /><strong>' + getLocalizationKey('TooltipSizeLabelText') + ' : </strong>' + opt.sizeFormatted + ' <span class=\'syncSc\'>('+opt.size+' bytes)</span><br /><strong>' + getLocalizationKey('TooltipModifiedLabelText') + ' : </strong>' + opt.dateFormatted + '<br /><strong>' + getLocalizationKey('TooltipKeywordsLabelText') + ' : </strong>' + crushFTPTools.xmlEncode(keywords) + '</div>" privs="' + escape(opt.privs) + '" sizeInBytes="' + opt.size + '" size="' + opt.sizeFormatted + '" fulldate="' + opt.modified + '" Date="' + opt.dateFormatted + '" Keywords="' + crushFTPTools.xmlEncode(keywords) + '" preview="' + opt.preview + '"><span class="fileSelectionMark"></span><div>' + '<div class="imgBox"><div class="imgWrapper">' + '<table cellspacing="0" cellpadding="0" align="center">' + '<tbody>' + '<tr>' + '<td valign="middle" align="center">' + '<a class="imgLink" rel="' + escape(unescape(opt.href_path)) + '" href="' + opt.href_path + '">' + '<img alt="' + opt.name + '" title="' + opt.name + '" style="border: 0px none;" src="' + o.spinerImage + '">' + '</a>' + '</td>' + '</tr>' + '</tbody>' + '</table></div>' + '</div>' + '</div>' + '<div class="imgTitle">' + '<a  rel="' + opt.root_dir + '" href="' + crushFTPTools.htmlEncode(opt.href_path, false, true) + '">' + fileName + '</a>' + '</div>' + '</li>';
                                        fileList.push(fileTemplate);
                                    }
                                } else {
                                    var subdirClass = opt.ItemType == "subDir" ? "subdirectory" : "";
                                    var attrs = "root_dir='" + opt.root_dir + "' name='" + opt.name + "' sizeInBytes='" + opt.size + "' size='" + opt.sizeFormatted + "' date='" + opt.dateFormatted + "' keywords='" + crushFTPTools.xmlEncode(keywords) + "' preview='" + opt.preview + "' privs='" + escape(opt.privs) + "'";
                                    var fileName = crushFTPTools.htmlEncode(opt.name, false, true);
                                    if (opt.type === 'DIR') {
                                        if (keywords.length >= o.MaximumLengthAllowedForKeywordsString) {
                                            keywords = keywords.substr(
                                            0, o.MaximumLengthAllowedForKeywordsString) + "...";
                                        }
                                        if(window.maskedEmptyFolder)
                                        {
                                            if(opt.size + "" == "0")
                                                subdirClass += " emptyFolder ";
                                        }
                                        var downloadURL = "draggable=\"true\" data-downloadurl=\"application/octet-stream:" + fileName + ".zip:" +linkURL+'?command=downloadAsZip&zipName='+fileName+'.zip&path='+crushFTPTools.htmlEncode(opt.href_path, false, true) + '&paths='+crushFTPTools.htmlEncode(opt.href_path, false, true)+"\"";
                                        fileList.push('<tr '+downloadURL+' index="' + x + '" name="' + opt.name + '" rootdir="' + opt.root_dir + '" modified="' + opt.modified + '" style="display:none;" privs="' + escape(opt.privs) + '" rel="' + escape(unescape(opt.root_dir)) + '" class="dirItemTR jqueryFileTree ' + subdirClass + '" sizeInBytes="' + opt.size + '" size="' + opt.sizeFormatted + '" fulldate="' + opt.modified + '" Date="' + opt.dateFormatted + '" Keywords="' + crushFTPTools.xmlEncode(keywords) + '" preview="' + opt.preview + '"><td class="columnSelect"><input class="chkBox" type="checkbox"/></td><td preview="' + opt.preview + '" ' + attrs + ' class="directory collapsed columnName '+syncedItemClass+'"><span class="expandButton" rel="' + escape(unescape(opt.href_path)) + '/"><img src="' + o.collapsedImageURL + '" /></span><a href="' + crushFTPTools.htmlEncode(opt.href_path, false, true) + '" rel="' + escape(unescape(opt.href_path)) + '/">' + fileName + '</a></td><td class="columnSize" size="' + opt.size + '"></td><td class="columnModified" modified="' + opt.modified + '">' + opt.dateFormatted + '</td><td class="columnKeywords" title="' + crushFTPTools.xmlEncode(keywords) + '">' +  crushFTPTools.xmlEncode(keywords) + '</td></tr>');
                                    } else if (opt.type === 'FILE') {
                                        if (keywords.length >= o.MaximumLengthAllowedForKeywordsString) {
                                            keywords = keywords.substr(
                                            0, o.MaximumLengthAllowedForKeywordsString) + "...";
                                        }
                                        var downloadURL = "draggable=\"true\" data-downloadurl=\"application/octet-stream:" + fileName + ":" +linkURL+crushFTPTools.htmlEncode(opt.href_path, false, true)+"\"";
                                        fileList.push('<tr '+downloadURL+' index="' + x + '" name="' + opt.name + '" rootdir="' + opt.root_dir + '" style="display:none;"  modified="' + opt.modified + '" privs="' + escape(opt.privs) + '" rel="' + escape(unescape(opt.root_dir)) + '" class="fileItemTR jqueryFileTree ' + subdirClass + '" sizeInBytes="' + opt.size + '" size="' + opt.sizeFormatted + '" fulldate="' + opt.modified + '" Date="' + opt.dateFormatted + '" Keywords="' + crushFTPTools.xmlEncode(keywords) + '" preview="' + opt.preview + '"><td class="columnSelect"><input class="chkBox" type="checkbox"/></td><td  preview="' + opt.preview + '" ' + attrs + ' class="fileTR columnName fileItem '+syncedItemClass+'"><a href="' + crushFTPTools.htmlEncode(opt.href_path, false, true) + '" rel="' + escape(unescape(opt.href_path)) + '">' + fileName + '</a></td><td class="columnSize" fulldate="' + opt.date + '" sizeInBytes="' + opt.size + '" size="' + opt.size + '">' + opt.sizeFormatted + '</td><td class="columnModified" modified="' + opt.modified + '">' + opt.dateFormatted + '</td><td class="columnKeywords" title="' + crushFTPTools.xmlEncode(keywords) + '">' + crushFTPTools.xmlEncode(keywords) + '</td></tr>');
                                    }
                                }
							}
						}
						//Draw links for current directory
                        drawPaginationLinks(curDirItems);
                        window.listingPageShown = false;
                        $(".layoutActionElement").show();
                        $("#filesListing").show();
                        $("#htmlListingFile").empty().hide();
                        return fileList.join("");//return html
					}
                    else
                    {
						drawPaginationLinks(curDirItems);
						return "";
					}
				}

				//Get file extension from file name
				function getFileExtension(filename) {
					var ext = /^.+\.([^.]+)$/.exec(filename);
					return ext == null ? "" : ext[1].toLowerCase();
				}

				//Hover effect of listing row
				function howerEffect(elem) {
					elem = elem || $(document);
					$(".jqueryFileTree", elem).unbind();
					$(".jqueryFileTree", elem).hover(function () {
						$(this).addClass("rowHover");
					}, function () {
						$(this).removeClass("rowHover");
					});
				}

				//Set hash location, its used to load directory
				function setHashLocation(s) {
					if (o.setHashLocation) {
						if (s.toString().length > 0) {
							hashListener.setHash(s);
						}
					}
				}

				//Get current hast location
				function getHash() {
					return document.location.hash;
				}

				//Show buttons based on privs
				function showButtonsBasedOnPriviledge() {
                    if(window.listingPageShown)return;
					renderButtons();
                    applyPrivs();
					if(!$(document).data("folderPrivs"))
						$("div.mainNavigation").find("a[href!='javascript:doLogout();']").parent().remove();
					$("div.mainNavigation").unblock();
				}

				/*Pagination methods*/
				window.current_page = o.pagingCurrentPage;
				var panel = $(".pagination");

				//Number of pages based on page size
				function numPages(customItem) {
					var curDirItems = customItem ? customItem : l;
					var maxentries = curDirItems.length;
					return Math.ceil(maxentries / o.defaultPageSize);
				}

				//Count interval based on page, page count and page size
				function getInterval(customItem) {
					var ne_half = Math.ceil(o.pagingNumDisplayEntries / 2);
					var np = numPages(customItem);
					var upper_limit = np - o.pagingNumDisplayEntries;
					var start = current_page > ne_half ? Math.max(Math.min(current_page - ne_half, upper_limit), 0) : 0;
					var end = current_page > ne_half ? Math.min(current_page + ne_half, np) : Math.min(o.pagingNumDisplayEntries, np);
					return [start, end];
				}

				//Select page, update page size and refresh view
				function pageSelected(page_id, evt, customItem) {
					$(".pagination").prepend("<span style='margin-right:5px;color:#777;'>(Loading...)</span>");
					setTimeout(function () {
						var curDirItems = customItem ? customItem : l;
						current_page = page_id;
						o.pagingCurrentPage = current_page;
						drawPaginationLinks();
						updatePageSizeOnLayout(true, customItem);
					}, 50);
				}

				//Select page
				function selectPage(page_id) {
					pageSelected(page_id);
				}

				//Go to prev page
				function prevPage() {
					if (current_page > 0) {
						pageSelected(current_page - 1);
						return true;
					} else {
						return false;
					}
				}

				//Draw pagination links
				function drawPaginationLinks(customItem) {
					panel.each(function () {
						var curPanel = $(this);
						var curDirItems = customItem ? customItem : l;
						curPanel.empty();
						var interval = getInterval(customItem);
						var np = numPages(curDirItems);
						if (np > 1 || o.pagingControlsShowAlways) {
							curPanel.show();
							var getClickHandler = function (page_id) {
									return function (evt) {
										return pageSelected(page_id, evt, curDirItems);
									}
								}
							var appendItem = function (page_id, appendopts) {
									page_id = page_id < 0 ? 0 : (page_id < np ? page_id : np - 1);
									appendopts = jQuery.extend({
										text: page_id + 1,
										classes: ""
									}, appendopts || {});
									if (page_id == current_page) {
										var lnk = jQuery("<span class='current'>" + (appendopts.text) + "</span>");
                                        if(appendopts.classes == "next" || appendopts.classes == "prev")
                                            lnk = jQuery("<span class='current disable'>" + (appendopts.text) + "</span>");
									} else {
										var lnk = jQuery("<a>" + (appendopts.text) + "</a>").bind("click", getClickHandler(page_id)).attr('href', "javascript:void(0);");
									}
									if (appendopts.classes) {
										lnk.addClass(appendopts.classes);
									}
									curPanel.append(lnk);
								}
							if (getLocalizationKey("pagingPrevText")) {
								appendItem(current_page - 1, {
									text: getLocalizationKey("pagingPrevText"),
									classes: "prev"
								});
							}
							if (interval[0] > 0 && o.pagingNumEdgeEntries > 0) {
								var end = Math.min(o.pagingNumEdgeEntries, interval[0]);
								for (var i = 0; i < end; i++) {
									appendItem(i);
								}
								if (o.pagingNumEdgeEntries < interval[0] && getLocalizationKey("pagingEllipseText")) {
									jQuery("<span>" + getLocalizationKey("pagingEllipseText ")+ "</span>").appendTo(curPanel);
								}
							}
							for (var i = interval[0]; i < interval[1]; i++) {
								appendItem(i);
							}
							if (interval[1] < np && o.pagingNumEdgeEntries > 0) {
								if (np - o.pagingNumEdgeEntries > interval[1] && getLocalizationKey("pagingEllipseText")) {
									jQuery("<span>" + getLocalizationKey("pagingEllipseText") + "</span>").appendTo(curPanel);
								}
								var begin = Math.max(np - o.pagingNumEdgeEntries, interval[1]);
								for (var i = begin; i < np; i++) {
									appendItem(i);
								}
							}
							if (getLocalizationKey("pagingNextText")) {
								appendItem(current_page + 1, {
									text: getLocalizationKey("pagingNextText"),
									classes: "next"
								});
							}
						} else {
							curPanel.hide();
						}
					});
				}
				/*End :: Pagination methods*/

				//Build breadcrumbs
				function bindBreadcrumbs() {
					var hashLoc = unescape(hashListener.getHash().toString().replace("#", ""));
					var dirs = hashLoc.split("/");
					var crumbs = "";
					var items = 0;

					function getLocation(num) {
						var newLoc = "";
						for (var i = 0; i < num; i++) {
							newLoc += dirs[i] + "/";
						}
						return crushFTPTools.decodeURILocal(newLoc);
					}
					for (var i = dirs.length - 1; i > 0; i--) {
						if (i < dirs.length - 2) {
							crumbs = "<li><a href='#" + escape(getLocation(i + 1)) + "'>" + dirs[i] + "</a></li>" + crumbs;
						} else {
							crumbs = "<li>" + dirs[i] + "</li>" + crumbs;
						}
						items += 1;
					}
					var userName = $(document).data("username") || "Home";
					crumbs = "<li class='home'><a href='#/' class='userHome'>" + userName + "</a></li>" + crumbs;
					$("#crumbs").parent().find("span.refreshButton").remove();
					$("#crumbs").html(crumbs).append("<span class='refreshButton' rel='" + hashLoc + "'><img src='" + o.refreshImageURL + "' /></span>");
					$(".refreshButton").unbind().click(function () {
						window.current_page = o.pagingCurrentPage = 0;
                        var path = "";
                        try{
                            path = crushFTPTools.encodeURILocal($(this).attr("rel"));
                        }
                        catch(ex){
                            path = $(this).attr("rel");
                        }
						if (currentView() == "Thumbnail") {
							showTree($("#filesContainerDiv"), path, true, true);
						} else {
							showTree($("#filesContainer"), path, true, true);
						}
					});
				}
				/**
				 * Vertigo Tip by www.vertigo-project.com Requires jQuery
				 */
				var border_right = $(window).width();
				var vtip = function (el, basket) {
					var lOffset = currentView(basket) == "Thumbnail" ? 20 : 40;
					var tOffset = currentView(basket) == "Thumbnail" ? 0 : 0;
					el = el || $(".vtip");
					$(el).cluetip({
						splitTitle: '^',
						showTitle: false,
						width: 'auto',
						cluetipClass: 'default',
                        clickThrough : true,
						arrows: true,
						tracking: currentView(basket) == "Thumbnail",
						positionBy: 'mouse',
						mouseOutClose: true,
						dropShadowSteps: 0,
						leftOffset: lOffset,
						topOffset: tOffset,
						dynamicLeftOffset: currentView(basket) != "Thumbnail"
					});
				};

                //All events to initiate on page load
				window.verifyUserStatus();
				// Loading message
				$(this).html('<table cellpadding="0" cellspacing="0" class="jqueryFileTree start"></table>');
				blockFileListingUI(true);
				// Get the initial file list
				bindUserName(true);

				/*Session checker will get version information, based on it new features will be show/hide/initiated*/
				$(".enterpriseFeature").hide();
				if ($("#SessionSeconds").sessionChecker)
				{
					$("#SessionSeconds").sessionChecker({
						callBack:function(){
							if (($(document).data("crushftp_version")+"").indexOf("6") >= 0) //show new features
							{
								if ($(document).data("crushftp_enterprise")) //show new features
								{
									$(".enterpriseFeature").show();
								}
                                else
                                {
                                    $(".enterpriseFeature").remove();
                                }
							}
							else
							{
								userLoginStatusCheckThread();
							}
						}
					});
				}

				bindUserCustomizationInfo();
                applyLocalizations();
                var currentViewType = $.cookie(o.ViewCookieName);
                if (currentViewType && currentViewType == "Thumbnail") {
                    $(".thumbnailViewLink", "#viewSelectorPanel").animate({
                        opacity: 0.3
                    }, 500);
                } else {
                    $(".treeViewLink", "#viewSelectorPanel").animate({
                        opacity: 0.3
                    }, 500);
                }
                if (currentView(true) == "Thumbnail") {
                    $(".thumbnailViewLink", "#viewSelectorPanelBasket").animate({
                        opacity: 0.3
                    }, 500);
                } else {
                    $(".treeViewLink", "#viewSelectorPanelBasket").animate({
                        opacity: 0.3
                    }, 500);
                }
				updatePageSizeOnLayout();
				loadPopupContent();
				bindPagingSizeMenu();
				bindSelectionMenu();
				$("#searchForm").attr("action", o.ajaxCallURL);
				bindBackToTop();
				$("#searchResultNotification").find("a").click(function () {
					$("#filter").val("").keyup().blur();
					$(document).removeData("searchData");
					$(".refreshButton").click();
				});
				$("#selectionOfItemsOptions").find("a.options").click(function () {
					window.listingInfo.selectedEverything = true;
					showSelectionInfoBar();
				});
				$("#selectionOfItemsOptions").find("a.actions").click(function () {
					window.listingInfo.selectedEverything = false;
					var tbl = $("#filesListing").find("table");
					toggleCheckBoxesAll(tbl, false);
					toggleMainCheckbox(tbl, false);
					selectDeselectAllItems(false);
				});

				if(!$(document).data("uploadOnly"))
				{
					$(window).scroll(function () {
						stickyRelocate();
					});
					stickyRelocate();
				}
                if($(document).data("slideShowOnly"))
                {
                    if(!$.CrushFTP.DNDAdded)
                    {
                        $.CrushFTP.attachDND(o);
                        $.CrushFTP.DNDAdded = true;
                    }
                }

                $("#loadingIndicator").dialog({
                    autoOpen: false,
                    dialogClass: "loadingIndicatorWindow",
                    closeOnEscape: false,
                    draggable: false,
                    width: 150,
                    minHeight: 50,
                    modal: false,
                    buttons: {},
                    resizable: false,
                    position: [false, 250],
                    open: function() {
                        $('body').css('overflow','hidden');
                    },
                    close: function() {
                        $('body').css('overflow','auto');
                    }
                });
                window.isMobileDevice = /Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent);
			});
		}
	});
})(jQuery);

function isScrolledIntoView(elem) {
	if(!elem ||  elem.length ==0) return;
	var docViewTop = $(window).scrollTop();
	var docViewBottom = docViewTop + $(window).height();
	var elemTop = $(elem).offset().top;
	var elemBottom = elemTop + $(elem).height();
	return ((elemBottom >= docViewTop) && (elemTop <= docViewBottom));
}

function stickyRelocate() {
    if($(document).data("uploadOnly") || window.isMobileDevice)return;
	var sticky = $('#mainNavigation, #fileQueueInfo, #dropItemsPanel');
	if (!isScrolledIntoView($('#mainNav-anchor'))) {
		sticky.addClass('stick');
         if($("#paddingPanel").length == 0)
            $("body").append("<div id='paddingPanel' style='height:100px'></div>");
	}
	else {
		sticky.removeClass('stick');
        $("#paddingPanel").remove();
	}
}

/* jslint browser: true */
/* global jQuery: true */
/**
 * jQuery Cookie plugin
 *
 * Copyright (c) 2010 Klaus Hartl (stilbuero.de) Dual licensed under the MIT and
 * GPL licenses: http://www.opensource.org/licenses/mit-license.php
 * http://www.gnu.org/licenses/gpl.html
 *
 */
jQuery.cookie = function (key, value, options) {
	// key and value given, set cookie...
	if (arguments.length > 1 && (value === null || typeof value !== "object")) {
		options = jQuery.extend({}, options);
		if (value === null) {
			options.expires = -1;
		}
		if (typeof options.expires === 'number') {
			var days = options.expires,
				t = options.expires = new Date();
			t.setDate(t.getDate() + days);
		}
		return (document.cookie = [
			crushFTPTools.encodeURILocal(key), '=', options.raw ? String(value) : crushFTPTools.encodeURILocal(String(value)), options.expires ? '; expires=' + options.expires.toUTCString() : '',
			// use expires attribute, max-age is not supported by IE
					options.path ? '; path=' + options.path : '', options.domain ? '; domain=' + options.domain : '', options.secure ? '; secure' : ''].join(''));
	}
	// key and possibly options given, get cookie...
	options = value || {};
	var result, decode = options.raw ?
	function (s) {
		return s;
	} : crushFTPTools.decodeURILocal;
	return (result = new RegExp('(?:^|; )' + crushFTPTools.encodeURILocal(key) + '=([^;]*)').exec(document.cookie)) ? decode(result[1]) : null;
};

//Initialize tabs
function initTabs() {
	$('.customtabs').each(function () {
		$(this).siblings('div').children('div:gt(0)').hide();
		$(this).children('a:first').addClass('active');
		$(this).find('a').click(function () {
			setTabByHandler(this);
			return false;
		});
	});
}

var crushFTPTools = {
	xmlUnSafeCharsMapping : {
		'&': '&amp;',
		'"': '&quot;',
		"'" : '&apos;',
		'<': '&lt;',
		'>': '&gt;'
	},
	xmlUnSafeCharsMappingReverse : {
		'&amp;' : '&',
		'&quot;' : '"',
		'&apos;' : "'",
		'&lt;' : '<',
		'&gt;' : '>',
		'%2B' : '+',
		'%25' : '%'
	},
	xmlEncode : function(value,onlyHTML)
	{
		if (value == undefined || value.length == 0) return value;
        if(onlyHTML)
        {
            try{
                value = crushFTPTools.decodeURILocal(value);
            }
            catch(ex){
                value = value;
            }
            return value.replace(/([\&'"<>])/g, function(str, item) {
              return crushFTPTools.xmlUnSafeCharsMapping[item];
            });
        }
        else
        {
            return value.replace(/([\&'"<>])/g, function(str, item) {
                return crushFTPTools.xmlUnSafeCharsMapping[item];
            }).replace(/\%/g, "%25").replace(/\+/g, "%2B");
        }
	},
	decodeXML : function(value)
	{
		if (value == undefined || value.length == 0) return value;
		 return value.replace(/(&quot;|&lt;|&gt;|&amp;|&apos;|%2B|%25)/g,
			function(str, item) {
				return crushFTPTools.xmlUnSafeCharsMappingReverse[item];
		});
	},
	htmlEncode : function(value, encodeVal, onlyHTML) {
		if(value != undefined && value.length>0)
		{
			var lines = value.split(/\r\n|\r|\n/);
			for (var i = 0; i < lines.length; i++) {
				if(lines[i] && typeof lines[i] == "string")
				lines[i] = crushFTPTools.xmlEncode(lines[i], onlyHTML);
			}
			if(encodeVal)
				return crushFTPTools.encodeURILocal(lines.join('\r\n'));
			else
				return lines.join('\r\n');
		}
		else
			return value;
	},
    decodeURILocal : function(val)
    {
        var _val = val;
        try{
            _val = decodeURIComponent(val);
        }
        catch(ex){
        }
        return _val;
    },
    encodeURILocal : function(val)
    {
        var _val = val;
        try{
            _val = encodeURIComponent(val);
        }
        catch(ex){}
        return _val;
    }
};

//Set current tab based on element
function setTabByHandler(elm) {
	if (elm && !$(elm).hasClass("disabledClick")) {
		var current_content_div = '#' + $(elm).attr('rel');
		$(elm).siblings().removeClass('active');
		$(elm).addClass('active');
		$(current_content_div).siblings().hide();
		$(current_content_div).show();
	}
	$(elm).blur();
	return false;
}

//Set current tab based on elem name
function setTabToElem(elm) {
	setTabByHandler($("a[rel='" + elm + "']:first"));
}

//Method to clear all items in current form
$.fn.clearForm = function () {
	return this.each(function () {
		var type = this.type,
			tag = this.tagName.toLowerCase();
		if (tag == 'form' || tag == 'div') return $(':input', this).clearForm();
		if (type == 'text' || type == 'password' || tag == 'textarea') this.value = '';
		else if (type == 'checkbox' || type == 'radio') this.checked = false;
		else if (tag == 'select') this.selectedIndex = -1;
	});
};

window.growl = function(title, content, warning, expires){
    $("#growlContainer").notify({
        speed: 500,
        expires: expires
    });
    var handler = $("#growlContainer")
        .notify({ custom:true })
        .notify("create", { title:title, text:content });
    $(handler.element).removeClass("ui-state-error ui-state-highlight");
    if(warning)
    {
        $(handler.element).addClass("ui-state-error");
    }
    else
    {
        $(handler.element).addClass("ui-state-highlight");
    }
}