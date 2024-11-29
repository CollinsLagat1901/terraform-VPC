resource "aws_eip" "nat" {
  count = length(var.public_subnet_cidrs)

  tags = merge(
    var.tags,
    {
      Name = format("nat-eip-%s", var.public_subnet_cidrs[count.index])
    }
  )
}

resource "aws_nat_gateway" "main" {
  count         = length(var.public_subnet_cidrs)
  allocation_id = aws_eip.nat[count.index].id
  subnet_id     = aws_subnet.public[count.index].id

  tags = merge(
    var.tags,
    {
      Name = format("nat-gateway-%s", var.public_subnet_cidrs[count.index])
    }
  )
}
