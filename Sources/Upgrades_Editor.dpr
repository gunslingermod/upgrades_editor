program Upgrades_Editor;

uses
  Forms,
  Main in 'Main.pas' {MainForm},
  Upgrade in 'Upgrade.pas',
  texture_loader in 'texture_loader.pas' {TextureSelectorForm},
  UpEditor in 'UpEditor.pas' {UpgradeEditor},
  TextInput in 'TextInput.pas' {TextInputForm},
  helper in 'helper.pas',
  AboutForm in 'AboutForm.pas' {About},
  InfluencesListForm in 'InfluencesListForm.pas' {InfluencesList},
  sysutils,
  dds_utils in 'dds_utils.pas',
  helpform in 'helpform.pas' {Help};

{$R *.res}

begin
  DecimalSeparator := '.';
  Application.Initialize;
  Application.Title := 'Upgrades Editor';
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TAbout, About);
  Application.CreateForm(TInfluencesList, InfluencesList);
  Application.CreateForm(THelp, Help);
  //  Application.CreateForm(TTextureSelectorForm, TextureSelectorForm);
//  Application.CreateForm(TUpgradeEditor, UpgradeEditor);
//  Application.CreateForm(TTextInputForm, TextInputForm);
  Application.Run;
end.
