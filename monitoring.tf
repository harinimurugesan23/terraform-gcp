# Notification channel (email)
resource "google_monitoring_notification_channel" "email_alert" {
  display_name = "Email Alerts"
  type         = "email"
  labels = {
    email_address = "harinimurugesan23@gmail.com" # Replace with your email
  }
}

# Alert policy for high CPU usage
resource "google_monitoring_alert_policy" "high_cpu_usage" {
  display_name = "High CPU Usage Alert"

  combiner = "OR"

  conditions {
    display_name = "VM CPU usage exceeds 80%"

    condition_threshold {
      filter          = "metric.type=\"compute.googleapis.com/instance/cpu/utilization\" AND resource.type=\"gce_instance\""
      duration        = "60s"
      comparison      = "COMPARISON_GT"
      threshold_value = 0.8

      aggregations {
        alignment_period   = "60s"
        per_series_aligner = "ALIGN_MEAN"
      }
    }
  }

  notification_channels = [google_monitoring_notification_channel.email_alert.id]

  documentation {
    content   = "CPU usage is above 80% for the past 1 minute."
    mime_type = "text/markdown"
  }

  user_labels = {
    environment = "production"
  }
}
