resource "aws_eks_cluster" "eks" {
  name     = "ethan-test-react-eks"
  role_arn = aws_iam_role.eks_role.arn

  vpc_config {
    subnet_ids = [
      data.aws_subnet.private1.id,
      data.aws_subnet.private2.id,
      data.aws_subnet.private3.id
    ]
    endpoint_private_access = true
    endpoint_public_access  = false
  }

  depends_on = [aws_iam_role_policy_attachment.eks_AmazonEKSClusterPolicy]
}

resource "aws_iam_role" "eks_role" {
  name = "ethan-eks-test-cluster-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Principal = {
        Service = "eks.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "eks_AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks_role.name
}
