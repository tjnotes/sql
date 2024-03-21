<configuration>
  <system.diagnostics>
    <sources>
      <source name="System.ServiceModel" switchValue="Information, ActivityTracing" propagateActivity="true">
        <listeners>
          <add name="traceListener" type="System.Diagnostics.XmlWriterTraceListener" initializeData="WcfTrace.svclog" />
        </listeners>
      </source>
      <source name="System.ServiceModel.MessageLogging" switchValue="Warning, ActivityTracing">
        <listeners>
          <add name="messageLogTraceListener" type="System.Diagnostics.XmlWriterTraceListener" initializeData="WcfMessages.svclog" />
        </listeners>
      </source>
    </sources>
  </system.diagnostics>
  <system.serviceModel>
    <diagnostics>
      <messageLogging logEntireMessage="true" logMalformedMessages="true"
                      logMessagesAtServiceLevel="true" logMessagesAtTransportLevel="true" />
    </diagnostics>
  </system.serviceModel>
</configuration>

