resource "aws_lb" "rancher-lb" {
  name               = "rancher-lb"
  internal           = false
  load_balancer_type = "network"
  subnets            = [aws_subnet.rancher_master.id]
}

resource "aws_lb_target_group" "rancher-http" {
  name     = "rancher-tg-http"
  port     = 80
  protocol = "TCP"
  vpc_id   = aws_vpc.cluster_lan.id
}

resource "aws_lb_target_group" "rancher-https" {
  name     = "rancher-tg-https"
  port     = 443
  protocol = "TCP"
  vpc_id   = aws_vpc.cluster_lan.id
}

resource "aws_lb_target_group" "rancher-kubeapi" {
  name     = "rancher-tg-kubeapi"
  port     = 6443
  protocol = "TCP"
  vpc_id   = aws_vpc.cluster_lan.id
}

resource "aws_lb_target_group" "rancher-kubereg" {
  name     = "rancher-tg-kubereg"
  port     = 9345
  protocol = "TCP"
  vpc_id   = aws_vpc.cluster_lan.id
}

resource "aws_lb_target_group_attachment" "http-attach" {
  count            = length(aws_instance.rancher_cluster)
  target_group_arn = aws_lb_target_group.rancher-http.arn
  target_id        = aws_instance.rancher_cluster[count.index].id
  port             = 80
}

resource "aws_lb_target_group_attachment" "https-attach" {
  count            = length(aws_instance.rancher_cluster)
  target_group_arn = aws_lb_target_group.rancher-https.arn
  target_id        = aws_instance.rancher_cluster[count.index].id
  port             = 443
}

resource "aws_lb_target_group_attachment" "kubeapi-attach" {
  count            = length(aws_instance.rancher_cluster)
  target_group_arn = aws_lb_target_group.rancher-kubeapi.arn
  target_id        = aws_instance.rancher_cluster[count.index].id
  port             = 6443
}

resource "aws_lb_target_group_attachment" "kubereg-attach" {
  count            = length(aws_instance.rancher_cluster)
  target_group_arn = aws_lb_target_group.rancher-kubereg.arn
  target_id        = aws_instance.rancher_cluster[count.index].id
  port             = 9345
}

resource "aws_lb_listener" "rancher-http" {
  load_balancer_arn = aws_lb.rancher-lb.arn
  port              = "80"
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.rancher-http.arn
  }
}

resource "aws_lb_listener" "rancher-https" {
  load_balancer_arn = aws_lb.rancher-lb.arn
  port              = "443"
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.rancher-https.arn
  }
}

resource "aws_lb_listener" "rancher-kubeapi" {
  load_balancer_arn = aws_lb.rancher-lb.arn
  port              = "6443"
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.rancher-kubeapi.arn
  }
}

resource "aws_lb_listener" "rancher-kubereg" {
  load_balancer_arn = aws_lb.rancher-lb.arn
  port              = "9345"
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.rancher-kubereg.arn
  }
}
