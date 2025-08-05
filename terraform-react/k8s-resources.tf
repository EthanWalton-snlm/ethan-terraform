resource "kubernetes_deployment" "react_app" {
  metadata {
    name = "react-app"
    labels = {
      app = "react"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "react"
      }
    }

    template {
      metadata {
        labels = {
          app = "react"
        }
      }

      spec {
        container {
          name  = "react"
          image = var.react_image
          port {
            container_port = 80
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "react_service" {
  metadata {
    name = "react-service"
  }

  spec {
    selector = {
      app = "react"
    }

    port {
      port        = 80
      target_port = 80
    }

    type = "ClusterIP"
  }
}
