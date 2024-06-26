locals {
  rds_engine         = "aurora-postgresql"
  rds_engine_version = "15.3"
  rds_cluster_identifier = "llm-ops-prd"
}

resource "aws_db_subnet_group" "rds_tokyo_db_subnet_group" {
  provider   = aws.primary
  name       = "dpsh-llm-ops-prd-db-subnet-group"
  subnet_ids = [data.aws_subnet.news_private_b_0.id, data.aws_subnet.news_private_c_0.id, data.aws_subnet.news_private_d_0.id]

  tags = {
    Cost   = var.cost
    Env    = "production"
    Name   = "dpsh-llm-ops-prd"
    Team   = var.team
    System = var.system
  }
}

resource "aws_rds_cluster" "rds_tokyo_cluster" {
  provider                    = aws.primary
  deletion_protection         = true
  engine                      = local.rds_engine
  engine_version              = local.rds_engine_version
  db_subnet_group_name        = aws_db_subnet_group.rds_tokyo_db_subnet_group.name
  vpc_security_group_ids      = [data.aws_security_group.smartnews.id]
  cluster_identifier          = "llm-ops-prd"
  master_username             = "postgres"
  master_password             = "postgres"
  database_name               = "pezzo"
  availability_zones          = ["ap-northeast-1b", "ap-northeast-1c", "ap-northeast-1d"]
  skip_final_snapshot         = true

  tags = {
    Cost   = var.cost
    Env    = "production"
    Name   = "dpsh-llm-ops-prd"
    Team   = var.team
    System = var.system
    Reserve = "Yes"
  }
}

resource "aws_rds_cluster_instance" "rds_tokyo_instances" {
  provider             = aws.primary
  count                = 1
  identifier           = "llm-ops-prd-${count.index}"
  cluster_identifier   = aws_rds_cluster.rds_tokyo_cluster.id
  instance_class       = "db.r6g.xlarge"
  engine               = local.rds_engine
  engine_version       = local.rds_engine_version
  db_subnet_group_name = aws_db_subnet_group.rds_tokyo_db_subnet_group.name
  promotion_tier       = 0


  tags = {
    Cost   = var.cost
    Env    = "production"
    Name   = "dpsh-llm-ops-prd"
    Team   = var.team
    System = var.system
    Reserve = "Yes"
  }
}
