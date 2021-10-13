data = [{'name' : 'thabo','cancer' : 'skin'},{'name' : 'thabo','cancer' : 'skin'},{'name' : 'thabo','cancer' : 'breast'},{'name' : 'thabo','cancer' : 'lung'}]
result = {}
for entry in data:
    if entry['cancer'] in result:
        result[entry['cancer']] += 1
    else:
        result[entry['cancer']] = 1

print(result)
