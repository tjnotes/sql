Imports System.Net.Http
Imports System.Text
Imports Newtonsoft.Json

Private Async Function CallCFIMSAsync(SRef As String, SCmd As String, SInfo As String, SImage As String, SAFERegID As Integer) As Task(Of Integer)
    ' Log the beginning of the operation
    My.Application.Log.WriteEntry("Creating CFIMS REST API Client Endpoint", TraceEventType.Verbose, SAFERegID)

    ' Create an instance of HttpClient
    Using client As New HttpClient()

        ' Define the REST API endpoint URL
        Dim apiUrl As String = "http://your_api_endpoint_here"

        ' Create the payload object
        Dim payload As New With {Key .SRef = SRef, Key .SCmd = SCmd, Key .SInfo = SInfo, Key .SImage = SImage, Key .SAFERegID = SAFERegID}

        ' Serialize the payload object to JSON
        Dim json As String = JsonConvert.SerializeObject(payload)

        ' Create the HttpContent for the request
        Using content As New StringContent(json, Encoding.UTF8, "application/json")

            ' Log transition to the next operation
            My.Application.Log.WriteEntry("Sending data to CFIMS REST API", TraceEventType.Verbose, SAFERegID)

            ' Send the POST request to the REST API endpoint
            Dim response As HttpResponseMessage = Await client.PostAsync(apiUrl, content)

            ' Ensure the request was successful
            response.EnsureSuccessStatusCode()

            ' Read the response content as a string
            Dim responseContent As String = Await response.Content.ReadAsStringAsync()

            ' Log the completion of the operation
            My.Application.Log.WriteEntry($"CFIMS REST API call completed with response: {responseContent}", TraceEventType.Information, SAFERegID)

            ' Deserialize the response content to an integer (or use it directly depending on your API response)
            Dim retCode As Integer = JsonConvert.DeserializeObject(Of Integer)(responseContent)

            Return retCode
        End Using
    End Using
End Function
