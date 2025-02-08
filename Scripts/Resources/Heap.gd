extends RefCounted

class_name Heap 

var max_heap : bool

var num_entries : int

var entries : Array

var indices : Dictionary

func _init(_max_heap : bool = false, _capacity : int = 32):
    max_heap = _max_heap
        
    entries.resize(_capacity)

func top(): 
    return (num_entries == 0) if null else entries.front()
    
func push(entry, value):
    if num_entries + 1 == entries.size():
        entries.resize(entries.size() << 1)
    
    entries[num_entries] = [entry, value]
    
    indices[entry] = num_entries;
    
    _percolate_up(num_entries)
    
    num_entries += 1
    
func pop():
    if is_empty():
        return
        
    var entry = top()
    
    num_entries -= 1
    
    indices.erase(top())
    
    entries[0] = entries[num_entries]
    entries[num_entries] = null
    
    if not is_empty():
        indices[top()] = 0
        _percolate_down(0)
     
    return entry
    
func modify(entry, value):
    if not indices.has(entry):
        return
    
    var index = indices[entry]
    
    if _compare(value, entries[index][1]):
        entries[index][1] = value
        
        _percolate_up(index)
    else:
        entries[index][1] = value
        
        _percolate_down(index)
  
func size():
    return num_entries
  
func is_empty():
    return num_entries == 0
    
func clear():    
    entries.fill(null)
    
    indices.clear()
    
    num_entries = 0
    
func _percolate_up(index : int):
    while index != 0:
        var new_index = (index - 1) >> 1
        
        if not _compare(entries[index][1], entries[new_index][1]):
            break
        
        _swap(index, new_index)
        
        index = new_index
        
func _percolate_down(index : int):
    while true:
        var new_index = (index << 1) + 2

        if new_index < num_entries and _compare(entries[new_index][1], entries[new_index - 1][1]):
            pass
        elif new_index - 1 < num_entries:
            new_index -= 1
        else:
            break
            
        if _compare(entries[new_index][1], entries[index][1]):
            _swap(index, new_index)
            
            index = new_index
        else:
            break
    
func _compare(val1, val2):
    return (val1 > val2) if max_heap else (val1 < val2)
    
func _swap(index1 : int, index2 : int):
    var temp = entries[index1]
    entries[index1] = entries[index2]
    entries[index2] = temp
    
    indices[entries[index1]] = index1
    indices[entries[index2]] = index2

func print_heap():
    for i in range(num_entries):
        print("[%s, %s]" % [entries[i][0], entries[i][1]])
