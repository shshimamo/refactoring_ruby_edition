managers = []
employees.each do |e|
  managers << if e.manager?
end

# =>
  
managers = employees.select {|e| e.manager?}

offices = employees.collect {|e| e.office}

# =>

manager_offices = employees.select {|e| e.manager?}.collect {|e| e.office}


##########

total = 0
employees.each {|e| total += e.salary}

# =>

total = employees.inject(0) {|sum, e| sum + e.salary }
