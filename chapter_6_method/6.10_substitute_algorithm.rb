def found_friends(people)
  friends = []
  people.each do |person|
    if(person == "Don")
      friends << "Don"
    end
    if(person == "John")
      friends << "John"
    end
  end
  return friends
end

# =>


def found_friends(people)
  people.select do |person|
    %w(Don John Ken).include? person
  end
end
