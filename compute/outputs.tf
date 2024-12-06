output "instance_id" {
  value = aws_instance.udemy_instance.id
}

output "instance_state" {
  value = aws_instance.udemy_instance.instance_state
}

output "key_pair_name" {
  value = aws_instance.udemy_instance.key_name
}
