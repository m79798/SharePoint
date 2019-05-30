﻿using System.Collections.Generic;
using System.Runtime.Serialization;

namespace TPCIP.ToolPingWebPart.DataModel
{
    [DataContract]
    public class IhtsoaService
    {
        [DataMember]
        public string accessType { get; set; }

        public string bestEffort { get; set; }

        public string dslam { get; set; }

        [DataMember]
        public string dslamCountry { get; set; }

        public string dslamCapacityIssue { get; set; }

        public string lid { get; set; }

        [DataMember]
        public string lineSpeedDown { get; set; }

        public string lineSpeedUp { get; set; }

        public string port { get; set; }

        public List<ServiceInfo> serviceInfo { get; set; }

        public List<ServiceInfo> services { get; set; }
        public string urlAdman { get; set; }

        public string urlDslmon { get; set; }
    }
}