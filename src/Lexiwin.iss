; Lexiwin - Inno Setup installation script file
;
; To generate a new installation file, update the version number
; "MyAppVersion" in the defines section, and click Build -> Compile.
;
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES

#define MyAppName "Lexiwin"
#define MyAppVersion "8.1"
#define MyAppPublisher "github.com/Zwyx"
#define MyAppURL "https://github.com/Zwyx/Lexiwin"
#define MyAppExeName "Lexiwin.exe"
#define MyAppCopyright "Copyright (C) 2012-2013 github.com/Zwyx"
#define MyAppDescription "Enhanced Windows Features"

[Setup]
; NOTE: The value of AppId uniquely identifies this application.
; Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{FE415FF3-99AA-47CB-8DC8-A60072E656EB}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
;AppVerName={#MyAppName} {#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
VersionInfoCopyright={#MyAppCopyright}
VersionInfoDescription={#MyAppDescription}
VersionInfoVersion={#MyAppVersion}
;DefaultDirName={pf}\{#MyAppName}
DefaultDirName={code:DefDirRoot}\{#MyAppName}
DefaultGroupName={#MyAppName}
AllowNoIcons=yes
LicenseFile=.\{#MyAppName}-License.txt
OutputDir=.
OutputBaseFilename=Lexiwin-{#MyAppVersion}-Setup
SetupIconFile=.\Lexiwin.ico
Compression=lzma
SolidCompression=yes
PrivilegesRequired=none

; Pascal scripting code
[Code]

(* Stop an eventually running Lexiwin instance *)
function InitializeSetup(): Boolean;
var
  ErrorCode: Integer;
begin
  ShellExec('open', 'tskill.exe', 'Lexiwin', '', SW_HIDE, ewNoWait, ErrorCode); (* On some computers, it is tskill *)
  ShellExec('open', 'taskkill.exe', '/f /im Lexiwin.exe', '', SW_HIDE, ewNoWait, ErrorCode); (* On some computers, it is taskkill *)
  result := True;
end;
function InitializeUninstall(): Boolean;
var
  ErrorCode: Integer;
begin
  ShellExec('open', 'tskill.exe', 'Lexiwin', '', SW_HIDE, ewNoWait, ErrorCode); (* On some computers, it is tskill *)
  ShellExec('open', 'taskkill.exe', '/f /im Lexiwin.exe', '', SW_HIDE, ewNoWait, ErrorCode); (* On some computers, it is taskkill *)
  result := True;
end;

(* Install in AppData if the user is not administrator *)
function IsRegularUser(): Boolean;
begin
  Result := not (IsAdminLoggedOn or IsPowerUserLoggedOn);
end;
function DefDirRoot(Param: String): String;
begin
  if IsRegularUser then
    Result := ExpandConstant('{userappdata}')
  else
    Result := ExpandConstant('{pf}')
end;

[Languages]
Name: "en"; MessagesFile: "compiler:Default.isl"
Name: "fr"; MessagesFile: "compiler:Languages\French.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked
Name: "quicklaunchicon"; Description: "{cm:CreateQuickLaunchIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked; OnlyBelowVersion: 0,6.1
Name: "autostart"; Description: "{cm:AutoStartProgram,{#MyAppName}}"; GroupDescription: "{cm:AutoStartProgramGroupDescription}"

[Files]
Source: ".\{#MyAppName}.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: ".\{#MyAppName}.ini"; DestDir: "{app}"; DestName: "{#MyAppName}-DefaultConfiguration.ini"; Flags: ignoreversion
Source: ".\{#MyAppName}.ini"; DestDir: "{userappdata}\{#MyAppName}"; Flags: ignoreversion confirmoverwrite
;Source: ".\{#MyAppName}-License.txt"; DestDir: "{app}"; Flags: ignoreversion
;Source: ".\{#MyAppName}-UserManual(Fr).pdf"; DestDir: "{app}"; Flags: ignoreversion
;Source: ".\{#MyAppName}-QuickReference(Fr).pdf"; DestDir: "{app}"; Flags: ignoreversion
;Source: ".\{#MyAppName}-DeveloperGuide(Fr).pdf"; DestDir: "{app}"; Flags: ignoreversion
; NOTE: Don't use "Flags: ignoreversion" on any shared system files

[InstallDelete]
; Delete previous versions files not used anymore
Type: files; Name: "{app}\Lexiwin.ini"
Type: files; Name: "{app}\License.txt"
Type: files; Name: "{group}\Lexiwin - UserManual (Fr).lnk"

[Icons]
Name: "{group}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"
Name: "{group}\{cm:LexiwinConfiguration}"; Filename: "{userappdata}\{#MyAppName}\{#MyAppName}.ini"
;Name: "{group}\{cm:LexiwinUserManual}"; Filename: "{app}\{#MyAppName}-UserManual(Fr).pdf"
;Name: "{group}\{cm:LexiwinQuickReference}"; Filename: "{app}\{#MyAppName}-QuickReference(Fr).pdf"
;Name: "{group}\{#MyAppName} - DeveloperGuide (Fr)"; Filename: "{app}\{#MyAppName}-DeveloperGuide(Fr).pdf"
Name: "{group}\{cm:ProgramOnTheWeb,{#MyAppName}}"; Filename: "{#MyAppURL}"
Name: "{group}\{cm:UninstallProgram,{#MyAppName}}"; Filename: "{uninstallexe}"
Name: "{commondesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: desktopicon
Name: "{userappdata}\Microsoft\Internet Explorer\Quick Launch\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: quicklaunchicon
Name: "{commonstartup}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: autostart

[Run]
Filename: "{app}\{#MyAppExeName}"; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}"; Flags: nowait postinstall skipifsilent
;Filename: "{app}\{#MyAppName}-UserManual(Fr).pdf"; Description: "{cm:LexiwinViewUserManual}"; Flags: shellexec nowait postinstall skipifsilent

[Messages]
en.FileExists=This file is the {#MyAppName} configuration file, would you like Setup to overwrite it?%n%nIf you never modified the {#MyAppName} configuration (which includes the quick launch lists and the saved windows sizes and positions), clic Yes. If you want keep your old configuration, clic No and refer to the user manual to know the new configuration options available with this new version of {#MyAppName}.
fr.FileExists=Ce fichier est le fichier de configuration de {#MyAppName}, voulez-vous que l'installation le remplace ?%n%nSi vous n'avez jamais modifi� la configuration de {#MyAppName} (qui inclue les listes de lancement rapide et les tailles et positions sauvegard�es des fen�tres), cliquez sur Oui. Si vous souhaitez conserver votre ancienne configuration, cliquez sur Non puis reportez-vous au manuel de l'utilisateur pour conna�tre les nouvelles options de configuration disponibles avec cette nouvelle version de {#MyAppName}.
en.WelcomeLabel2=This will install [name/ver] on your computer.
fr.WelcomeLabel2=Cet assistant va vous guider dans l'installation de [name/ver] sur votre ordinateur.
;BeveledLabel=Inno Setup

[CustomMessages]
en.AutoStartProgram=Automatically start %1 at computer startup
fr.AutoStartProgram=D�marrer automatiquement %1 au d�marrage de l'ordinateur
en.LexiwinUserManual=User Manual
fr.LexiwinUserManual=Manuel de l'utilisateur
en.LexiwinQuickReference=Quick Reference
fr.LexiwinQuickReference=Fiche de r�f�rence
en.LexiwinConfiguration={#MyAppName} Configuration
fr.LexiwinConfiguration=Configuration de {#MyAppName}
en.LexiwinViewUserManual=View the user manual (PDF)
fr.LexiwinViewUserManual=Afficher le manuel de l'utilisateur (en PDF)
