#-----------------------------------------------------------
# Global or/and default variables
#-----------------------------------------------------------
variable "name" {
  description = "Name to be used on all resources as prefix"
  default     = "TEST"
}

variable "environment" {
  description = "Environment for service"
  default     = "STAGE"
}

variable "tags" {
  description = "A list of tag blocks."
  type        = map(string)
  default     = {}
}

#-----------------------------------------------------------
# ELB
#-----------------------------------------------------------
variable "enable_elb" {
  description = "Enable ELB usage"
  default     = false
}

variable "elb_name" {
  description = "The name of the ELB. By default generated by Terraform."
  default     = ""
}

variable "availability_zones" {
  description = "Availability zones for AWS ASG"
  default     = null
}

variable "security_groups" {
  description = "A list of security group IDs to assign to the ELB. Only valid if creating an ELB within a VPC"
  default     = []
}

variable "subnets" {
  description = "A list of subnet IDs to attach to the ELB"
  default     = null
}

variable "elb_internal" {
  description = "If true, ELB will be an internal ELB"
  default     = false
}

variable "cross_zone_load_balancing" {
  description = "Enable cross-zone load balancing. Default: true"
  default     = true
}

variable "idle_timeout" {
  description = "The time in seconds that the connection is allowed to be idle. Default: 60"
  default     = 60
}

variable "connection_draining" {
  description = "Boolean to enable connection draining. Default: false"
  default     = false
}

variable "connection_draining_timeout" {
  description = "The time in seconds to allow for connections to drain. Default: 300"
  default     = 300
}

variable "access_logs" {
  description = "An access logs block. Uploads access logs to S3 bucket"
  default     = []
}

variable "listener" {
  description = "A list of Listener block"
  default     = []
}

variable "health_check" {
  description = " Health check"
  default     = []
}

#-----------------------------------------------------------
# ELB attachment
#-----------------------------------------------------------
variable "enable_elb_attachment" {
  description = "Enable elb_attachment usage"
  default     = false
}

variable "instances" {
  description = " Instances ID to add them to ELB"
  default     = []
}

variable "elb_id" {
  description = "ID of ELB"
  default     = ""
}

#-----------------------------------------------------------
# ELB cookie_stickiness_policy
#-----------------------------------------------------------
variable "enable_lb_cookie_stickiness_policy_http" {
  description = "Enable lb cookie stickiness policy http. If set true, will add it, else will use https"
  default     = true
}

variable "lb_cookie_stickiness_policy_http_name" {
  description = "Name for lb_cookie_stickiness_policy_http"
  default     = ""
}

variable "lb_cookie_stickiness_policy_https_name" {
  description = "Name for lb_cookie_stickiness_policy_https"
  default     = ""
}

variable "enable_app_cookie_stickiness_policy_http" {
  description = "Enable app cookie stickiness policy http. If set true, will add it, else will use https"
  default     = true
}

variable "app_cookie_stickiness_policy_http_name" {
  description = "Name for app_cookie_stickiness_policy_http"
  default     = ""
}

variable "app_cookie_stickiness_policy_https_name" {
  description = "Name for app_cookie_stickiness_policy_http"
  default     = ""
}

variable "http_lb_port" {
  description = "Set http lb port for lb_cookie_stickiness_policy_http|app_cookie_stickiness_policy_http policies"
  default     = 80
}

variable "https_lb_port" {
  description = "Set https lb port for lb_cookie_stickiness_policy_http|app_cookie_stickiness_policy_http policies"
  default     = 443
}

variable "cookie_expiration_period" {
  description = "Set cookie expiration period"
  default     = 600
}

variable "cookie_name" {
  description = "Set cookie name"
  default     = "SessionID"
}
