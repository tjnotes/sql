Imports System.Xml.Linq

Module Module1
    Sub Main()
        ' Path to your web.config or app.config file
        Dim configPath As String = "path_to_your_config_file_here"

        ' Load the configuration file
        Dim config As XDocument = XDocument.Load(configPath)

        ' Query the appSettings
        Dim appSettings = config.Element("configuration").Element("appSettings").Elements("add")

        ' Retrieve a specific setting by key
        Dim specificSetting = appSettings.FirstOrDefault(Function(e) e.Attribute("key").Value = "YourSettingKey")

        If specificSetting IsNot Nothing Then
            Dim settingValue As String = specificSetting.Attribute("value").Value
            Console.WriteLine($"Value for YourSettingKey: {settingValue}")
        Else
            Console.WriteLine("Setting key not found.")
        End If
    End Sub
End Module
