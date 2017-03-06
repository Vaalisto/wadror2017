module Top
  def top(n)
    return all.sort_by{ |b| -(b.average_rating||0) }[0,n]
  end
end