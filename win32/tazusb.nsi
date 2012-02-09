; Tazusb
; Windows installer for Slitaz
; (c) 2009 Cedric Tissieres (slitaz@objectif-securite.ch)
; You'll need to put 7z.exe and 7z.dll from http://www.7-zip.org/ and syslinux.exe from http://syslinux.zytor.com/ 
; in the NSIS plugins directory before compiling the script. Adapt the FROM_DIR constant too. 
; To add a translation, add the corresponding "!insertmacro MUI_LANGUAGE" and translates all the LangString you'll find below.  

!define NAME "TazUSB - SliTaz LiveUSB utility "
!define FILENAME "tazusb"
!define VERSION "v0.2"
!define FROM_DIR "C:\ophcrack\livecd"

SetCompressor LZMA
CRCCheck On
XPStyle on

!include "MUI2.nsh"
!include "FileFunc.nsh"


# MUI Settings #####################################
;**************

; Interface settings
!define MUI_FINISHPAGE_NOAUTOCLOSE
!define MUI_HEADERIMAGE
!define MUI_HEADERIMAGE_BITMAP "${FROM_DIR}\slitaz-logo-nsis.bmp" 
!define MUI_HEADERIMAGE_BITMAP_NOSTRETCH

; Welcome page
!define MUI_WELCOMEPAGE_TITLE $(Welcome_Title)
!define MUI_WELCOMEPAGE_TEXT $(Welcome_Text)
!insertmacro MUI_PAGE_WELCOME
; ISO page
Var IsoFileHw
Var IsoFile
Var Label
Var Label2
Page custom isoFilePage
; Drive page
Var DestDriveHW
Var DestDrive
Page custom drivePage
; Warning page
Page custom warningPage
; Instfiles page
!insertmacro MUI_PAGE_INSTFILES
; Finish page
!define MUI_FINISHPAGE_TITLE $(Finish_Title)
!define MUI_FINISHPAGE_TEXT $(Finish_Text)
!define MUI_FINISHPAGE_LINK $(Finish_Link)
!define MUI_FINISHPAGE_LINK_LOCATION "http://slitaz.org"
!insertmacro MUI_PAGE_FINISH

; Language files
!insertmacro MUI_LANGUAGE "English" ;first language is the default language
!insertmacro MUI_LANGUAGE "French"
!insertmacro MUI_LANGUAGE "Portuguese"


; Reserve files

; MUI end ------

; General Parameters
Name "${NAME} ${VERSION}"
OutFile "${FROM_DIR}\${FILENAME}.exe"

# Languages ######################################

; English
LangString Welcome_Title ${LANG_ENGLISH} "${NAME}"
LangString Welcome_Text ${LANG_ENGLISH} "Welcome to TazUSB. This tool will help you install Slitaz on a USB drive."
LangString Finish_Title ${LANG_ENGLISH} "TazUSB has completed Slitaz installation."
LangString Finish_Text ${LANG_ENGLISH} "Slitaz is now installed on your USB drive and the drive is bootable."
LangString Finish_Link ${LANG_ENGLISH} "Slitaz website"
LangString IsoPage_Title ${LANG_ENGLISH} "Select ISO file"
LangString IsoPage_Title2 ${LANG_ENGLISH} "Choose the ISO image which will be installed on your USB drive."
LangString IsoPage_Text ${LANG_ENGLISH} "Select Slitaz ISO file to be installed on your USB drive. You can download it from http://www.slitaz.org if needed."
LangString IsoPage_Input ${LANG_ENGLISH} "Slitaz ISO File"
LangString IsoFile ${LANG_ENGLISH} "ISO file|*.iso"
LangString DrivePage_Title ${LANG_ENGLISH} "Choose USB drive location"
LangString DrivePage_Title2 ${LANG_ENGLISH} "Choose the USB drive in which to install Slitaz."
LangString DrivePage_Text ${LANG_ENGLISH} "TazUSB will install Slitaz in the following drive. Make sure that this drive can be safely deleted! Click Next to continue."
LangString DrivePage_Input ${LANG_ENGLISH} "Destination USB Drive"
LangString WarningPage_Title ${LANG_ENGLISH} "Warning!"
LangString WarningPage_Title2 ${LANG_ENGLISH} "TazUSB is ready to install Slitaz on the selected drive."
LangString WarningPage_Text ${LANG_ENGLISH} "TazUSB is now ready to install Slitaz from:$\r$\n$\r$\n$IsoFile $\r$\n$\r$\non your selected destination USB drive:$\r$\n$\r$\n$DestDrive. $\r$\n$\r$\nThe contents of this drive will be deleted! If you are sure, click Next to continue."
LangString Iso2USB_Extract ${LANG_ENGLISH} "Extract files from $IsoFile"
LangString Iso2USB_CreateSyslinux ${LANG_ENGLISH} "Create syslinux configuration files on $DestDrive"
LangString Iso2USB_ExecuteSyslinux ${LANG_ENGLISH} "Execute syslinux on $R0"
LangString Iso2USB_WarningSyslinux ${LANG_ENGLISH} "An error ($R8) occurred when executing syslinux.$\r$\nYour USB drive won't be bootable..."

; French
LangString Welcome_Title ${LANG_FRENCH} "${NAME}"
LangString Welcome_Text ${LANG_FRENCH} "Bienvenue dans TazUSB. Cet outil va vous aider à installer Slitaz sur une clé USB."
LangString Finish_Title ${LANG_FRENCH} "L'installation a été terminée par TazUSB."
LangString Finish_Text ${LANG_FRENCH} "Slitaz est maintenant installé sur votre clé USB et celle-ci est démarrable."
LangString Finish_Link ${LANG_FRENCH} "Site web de Slitaz"
LangString IsoPage_Title ${LANG_FRENCH} "Sélectionner un fichier ISO"
LangString IsoPage_Title2 ${LANG_FRENCH} "Choisissez l'image ISO qui sera installée sur votre clé USB."
LangString IsoPage_Text ${LANG_FRENCH} "Sélectionnez l'image ISO de Slitaz qui sera installée sur votre clé USB. Vous pouvez en télécharger une sur http://www.slitaz.org au besoin."
LangString IsoPage_Input ${LANG_FRENCH} "Image ISO Slitaz"
LangString IsoFile ${LANG_FRENCH} "Image ISO|*.iso"
LangString DrivePage_Title ${LANG_FRENCH} "Sélectionner un lecteur USB"
LangString DrivePage_Title2 ${LANG_FRENCH} "Choisissez le lecteur USB sur lequel sera installé Slitaz"
LangString DrivePage_Text ${LANG_FRENCH} "TazUSB va maintenant installer Slitaz sur le lecteur sélectionné ci-dessous. Assurez-vous que les données contenues sur cette clé peuvent être effacées! Cliquer sur Suivant pour continuer."
LangString DrivePage_Input ${LANG_FRENCH} "Lecteur USB de destination"
LangString WarningPage_Title ${LANG_FRENCH} "Attention!"
LangString WarningPage_Title2 ${LANG_FRENCH} "TazUSB est prêt à installer Slitaz sur le lecteur sélectionné."
LangString WarningPage_Text ${LANG_FRENCH} "TazUSB est maintenant prêt à installer Slitaz depuis:$\r$\n$\r$\n$IsoFile $\r$\n$\r$\nsur le lecteur USB sélectionné:$\r$\n$\r$\n$DestDrive. $\r$\n$\r$\nLe contenu de ce lecteur peut être effacé! Si vous êtes sûr, cliquer sur Suivant pour continuer."
LangString Iso2USB_Extract ${LANG_FRENCH} "Extraction des fichiers de $IsoFile"
LangString Iso2USB_CreateSyslinux ${LANG_FRENCH} "Création de la configuration syslinux sur $DestDrive"
LangString Iso2USB_ExecuteSyslinux ${LANG_FRENCH} "Exécution de syslinux sur $R0"
LangString Iso2USB_WarningSyslinux ${LANG_FRENCH} "Une erreur ($R8) est survenue pendant l'exécution de syslinux.$\r$\n Votre clé USB ne sera pas démarrable..."

; Portuguese
LangString Welcome_Title ${LANG_PORTUGUESE} "${NAME}"
LangString Welcome_Text ${LANG_PORTUGUESE} "Bem-vindo ao TazUSB. Este aplicativo o ajudará a instalar o SliTaz em um drive USB."
LangString Finish_Title ${LANG_PORTUGUESE} "O TazUSB finalizou a instalação do SliTaz."
LangString Finish_Text ${LANG_PORTUGUESE} "O SliTaz está instalado em seu drive USB e o processo de boot agora pode ser feito."
LangString Finish_Link ${LANG_PORTUGUESE} "Site do Slitaz"
LangString IsoPage_Title ${LANG_PORTUGUESE} "Selecionar arquivo ISO"
LangString IsoPage_Title2 ${LANG_PORTUGUESE} "Escolher imagem ISO a ser instalada no drive USB."
LangString IsoPage_Text ${LANG_PORTUGUESE} "Selecionar imagem ISO do SliTaz a ser instalada no drive USB. Você pode obtê-la, se necessário, em http://www.slitaz.org."
LangString IsoPage_Input ${LANG_PORTUGUESE} "Arquivo ISO do SliTaz"
LangString IsoFile ${LANG_PORTUGUESE} "Arquivo ISO|*.iso"
LangString DrivePage_Title ${LANG_PORTUGUESE} "Escolha a localização do drive USB"
LangString DrivePage_Title2 ${LANG_PORTUGUESE} "Escolha o drive USB no qual o SliTaz será instalado."
LangString DrivePage_Text ${LANG_PORTUGUESE} "O TazUSB instalará o SliTaz no seguinte drive. Certifique-se de que o conteúdo deste drive possa ser seguramente apagado! Clique Next para continuar."
LangString DrivePage_Input ${LANG_PORTUGUESE} "Drive USB de destino"
LangString WarningPage_Title ${LANG_PORTUGUESE} "Aviso!"
LangString WarningPage_Title2 ${LANG_PORTUGUESE} "O TazUSB está pronto para instalar o SliTaz no drive selecionado."
LangString WarningPage_Text ${LANG_PORTUGUESE} "O TazUSB está pronto para instalar o SliTaz de:$\r$\n$\r$\n$IsoFile $\r$\n$\r$\nem seu drive de destino selecionado:$\r$\n$\r$\n$DestDrive. $\r$\n$\r$\nO conteúdo deste drive será apagado! Para prosseguir com a operação, clique Next para continuar."
LangString Iso2USB_Extract ${LANG_PORTUGUESE} "Extrair arquivos de $IsoFile"
LangString Iso2USB_CreateSyslinux ${LANG_PORTUGUESE} "Criar arquivos de configuração do syslinux em  $DestDrive"
LangString Iso2USB_ExecuteSyslinux ${LANG_PORTUGUESE} "Executar syslinux em $R0"
LangString Iso2USB_WarningSyslinux ${LANG_PORTUGUESE} "Um erro ($R8) ocorreu durante a execução do syslinux.$\r$\nSeu drive USB não será inicializável..."

# Functions #######################################

Function isoFilePage

  !insertmacro MUI_HEADER_TEXT $(IsoPage_Title) $(IsoPage_Title2) 
 
  nsDialogs::Create 1018
  
  ${If} $IsoFile == ""
    GetDlgItem $6 $HWNDPARENT 1 ; Get "Next" control handle
    EnableWindow $6 0 ; disable "Next" control
  ${EndIf}
 
  ${NSD_CreateLabel} 0 0 100% 30 $(IsoPage_Text)
  Pop $Label

  ${NSD_CreateLabel} 15 102 100% 15 $(IsoPage_Input)
  Pop $Label2
  
  nsDialogs::CreateControl EDIT ${DEFAULT_STYLES}|${WS_TABSTOP}|${ES_AUTOHSCROLL}|${ES_READONLY} ${WS_EX_WINDOWEDGE}|${WS_EX_CLIENTEDGE} 10 120 85% 20 $IsoFile
  Pop $IsoFileHw
        
  ${NSD_CreateBrowseButton} 89% 120 7% 20 ...
  Var /GLOBAL IsoFile_BrowseButton
  Pop $IsoFile_BrowseButton 
  GetFunctionAddress $0 OnClick_IsoFile_BrowseButton
  nsDialogs::OnClick $IsoFile_BrowseButton $0
  
  nsDialogs::Show
FunctionEnd

Function OnClick_IsoFile_BrowseButton


nsDialogs::SelectFileDialog /NOUNLOAD open "" $(IsoFile)
Pop $0

${If} $0 != ""
   ${NSD_SetText} $IsoFileHw $0
   StrCpy $IsoFile "$0"
   GetDlgItem $6 $HWNDPARENT 1 ; Get "Next" control handle
   EnableWindow $6 1 ; enable "Next" control
${EndIf}

FunctionEnd

Function drivePage

  !insertmacro MUI_HEADER_TEXT $(DrivePage_Title) $(DrivePage_Title2)
 
  nsDialogs::Create 1018
  
  ${If} $DestDrive == ""
    GetDlgItem $6 $HWNDPARENT 1 ; Get "Next" control handle
    EnableWindow $6 0 ; disable "Next" control
  ${EndIf}
 
  ${NSD_CreateLabel} 0 0 100% 30 $(DrivePage_Text)
  Pop $Label
  
  ${NSD_CreateLabel} 15 102 100% 15 $(DrivePage_Input)
  Pop $Label2
  
  ${NSD_CreateDroplist} 10 120 85% 20 ""
	Pop $DestDriveHw
		${NSD_OnChange} $DestDriveHw db_select.onchange
		${GetDrives} "FDD+HDD" driveListFiller
  ${If} $DestDrive != ""
	${NSD_CB_SelectString} $DestDriveHw $DestDrive
  ${EndIf}
  
  nsDialogs::Show
FunctionEnd

Function db_select.onchange
  Pop $DestDriveHw
  ${NSD_GetText} $DestDriveHw $0
  StrCpy $DestDrive "$0"
  GetDlgItem $6 $HWNDPARENT 1 ; Get "Next" control handle
  EnableWindow $6 1 ; enable "Next" control
FunctionEnd

Function driveListFiller
	SendMessage $DestDriveHw ${CB_ADDSTRING} 0 "STR:$9"
	Push 1 ; must push something - see GetDrives documentation
FunctionEnd

Function warningPage

  !insertmacro MUI_HEADER_TEXT $(WarningPage_Title) $(WarningPage_Title2)
 
  nsDialogs::Create 1018
 
  ${NSD_CreateLabel} 0 0 100% 80% $(WarningPage_Text)
  Pop $Label
  
  nsDialogs::Show
FunctionEnd

Function ExtractIt
  ; Code taken from 7zarchive.nsh  (c) 2008 qwertymodo
  
  InitPluginsDir
  File /oname=$PLUGINSDIR\7z.exe "${NSISDIR}\plugins\7z.exe"
  File /oname=$PLUGINSDIR\7z.dll "${NSISDIR}\plugins\7z.dll"

  ClearErrors

  Exch $0      ; ADDITIONAL_PARAMETERS (added to the end of the program call)
  Exch 1
  Exch $1      ; EXTRACT_PATHS (either "fullpaths" or "nopaths"; defaults to nopaths)
  Exch 2
  Exch $2      ; DESTINATION_FOLDER
  Exch 3
  Exch $3      ; FILE_FILTER (if blank, extracts all files; allows for wildcards, e.g. "*.doc")
  Exch 4
  Exch $4      ; SOURCE_ARCHIVE
  Push $5

  ;Extract all files if no filter specified
  StrCmp $3 "" +2 0
  StrCpy $3 "$\"$3$\""

  ;Default folder if not specified
  StrCmp $2 "" 0 GotFolder
  !insertmacro GetParent
  ${GetParent} "$4" $2
  !insertmacro GetBaseName
  ${GetBaseName} "$4" $5
  StrCpy $2 "$2\$5"

  GotFolder:
  CreateDirectory $2
  StrCmp $1 "fullpaths" 0 +2
  StrCpy $5 "x"
  StrCmp $1 "nopaths" +2 0
  StrCmp $1 "" 0 +2
  StrCpy $5 "e"

  nsExec::ExecToLog '"$PLUGINSDIR\7z.exe" x $\"$4$\" $\"-o$2$\" $3 $0'

  Pop $0 ;nsExec return value

  Pop $5
  Pop $4
  Pop $0
  Pop $1
  Pop $2
  Pop $3

FunctionEnd

!macro _ExtractFromArchive SOURCE_ARCHIVE FILE_FILTER DESTINATION_FOLDER EXTRACT_PATHS ADDITIONAL_PARAMETERS
  Push "${SOURCE_ARCHIVE}"
  Push "${FILE_FILTER}"
  Push "${DESTINATION_FOLDER}"
  Push "${EXTRACT_PATHS}"
  Push "${ADDITIONAL_PARAMETERS}"
  Call ExtractIt
!macroend

!define ExtractFromArchive '!insertmacro "_ExtractFromArchive"'


Function .onInit

  !insertmacro MUI_LANGDLL_DISPLAY

FunctionEnd

# Section #######################################


Section "iso2usb" main
  InitPluginsDir
  File /oname=$PLUGINSDIR\syslinux.exe "${NSISDIR}\plugins\syslinux.exe"
  
  SetShellVarContext all
  
  ; Extract files from archive
  DetailPrint $(Iso2USB_Extract)
  ${ExtractFromArchive} "$IsoFile" "" "$DestDrive" "" "-y -x![BOOT]*"

  ; Create syslinux directory and files
  Var /GLOBAL BootDir
  StrCpy $BootDir $DestDrive -1 
  StrCpy $BootDir "$BootDir\boot"
  IfFileExists "$BootDir\syslinux\syslinux.cfg" SkipCreateSyslinux CreateSyslinux
  CreateSyslinux:
  DetailPrint $(Iso2USB_CreateSyslinux) 
  CreateDirectory "$BootDir\syslinux"
  CopyFiles "$BootDir\isolinux\*.*" "$BootDir\syslinux"
  Rename "$BootDir\syslinux\isolinux.cfg" "$BootDir\syslinux\syslinux.cfg"

  SkipCreateSyslinux:
  ; Execute syslinux on the drive
  StrCpy $R0 $DestDrive -1 ; remove \ for syslinux
  ClearErrors
  DetailPrint $(Iso2USB_ExecuteSyslinux)
   	  ExecWait '$PLUGINSDIR\syslinux.exe -maf -d boot\syslinux $R0' $R8
  	  DetailPrint "Return $R8"

      Banner::destroy
	  ${If} $R8 != 0
            MessageBox MB_ICONEXCLAMATION|MB_OK $(Iso2USB_WarningSyslinux)
	  ${EndIf}
  
SectionEnd
