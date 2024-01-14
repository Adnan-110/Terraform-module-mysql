resource "null_resource" "schema" {
  # This make sure that null resource will ony be executed post the creation of the RDS/MYSQL only 
  depends_on = [ aws_db_instance.mysql]

  provisioner "local-exec" {
    command = <<EOF
        cd /tmp
        curl -s -L -o /tmp/mysql.zip "https://github.com/stans-robot-project/mysql/archive/main.zip"
        unzip -o mysql.zip
        cd mysql-main
        mysql -h ${aws_db_instance.mysql.address} -uadmin1 -pRoboShop1 < shipping.sql
    EOF
  }
}

# 1) Creates Resource 
# 2) Null provisioner authenticates/establishes connection to the newly created resource
# 3) Then executes tasks mentioned in the remote_exec block

