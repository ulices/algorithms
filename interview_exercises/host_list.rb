# Given an array of CSV strings representing search results, output results sorted by a score initially. A given host may have several listings that show up in these results. Suppose we want to show 12 results per page, but we don’t want the same host to dominate the results.

# Write a function that will reorder the list so that a host shows up at most once on a page if possible, but otherwise preserves the ordering. Your program should return the new array and print out the results in blocks representing the pages.

#Given an array of csv strings, output results separated by a blank line.



# "1,28,300.1,SanFrancisco\n4,5,209.1,SanFrancisco\n20,7,208.1,SanFrancisco\n23,8,207.1,SanFrancisco\n16,10,206.1,Oakland\n1,16,205.1,SanFrancisco\n6,29,204.1,SanFrancisco\n7,20,203.1,SanFrancisco\n8,21,202.1,SanFrancisco\n2,18,201.1,SanFrancisco\n2,30,200.1,SanFrancisco\n15,27,109.1,Oakland\n10,13,108.1,Oakland\n11,26,107.1,Oakland\n12,9,106.1,Oakland\n13,1,105.1,Oakland\n22,17,104.1,Oakland\n1,2,103.1,Oakland\n28,24,102.1,Oakland\n18,14,11.1,SanJose\n6,25,10.1,Oakland\n19,15,9.1,SanJose\n3,19,8.1,SanJose\n3,11,7.1,Oakland\n27,12,6.1,Oakland\n1,3,5.1,Oakland\n25,4,4.1,SanJose\n5,6,3.1,SanJose\n29,22,2.1,SanJose\n30,23,1.1,SanJose"

# host = 1
# sore = 28
# cost = 300.1
# city = SanFrancisco

# [host-1, host-2...host-12]

# 


require 'minitest/autorun'
require 'byebug'

class HostMngr
  attr_accessor :host_list, :sorted_list
  

  def initialize(host_list)
    @host_list = host_list
    @sorted_list = []
    sort_list
  end

  def storage_hosts
    host_list.split("\n").each do |row|
      host_row = row.split(',')
      sorted_list << { host: host_row[0].to_i, score: host_row[1].to_i, cost: host_row[2].to_f, city: host_row[3] }
    end
  end
  
  def sort_list
    storage_hosts
    
    sorted_list.sort_by! do |row|
      [row[:host], -row[:score]]
    end

  end
  
  def paginate
    pages = []
    filtered_host = sorted_list.uniq{|row| row[:host] }
    filtered_host.each_slice(12){|page| pages << page }
    pages
  end
  
  def first_host
    sorted_list.first
  end

  def last_host
    sorted_list.last
  end
end


describe HostMngr do
  it 'must sort and display first host' do
    host_list = "1,28,300.1,SanFrancisco\n4,5,209.1,SanFrancisco\n20,7,208.1,SanFrancisco\n23,8,207.1,SanFrancisco\n16,10,206.1,Oakland\n1,16,205.1,SanFrancisco\n6,29,204.1,SanFrancisco\n7,20,203.1,SanFrancisco\n8,21,202.1,SanFrancisco\n2,18,201.1,SanFrancisco\n2,30,200.1,SanFrancisco\n15,27,109.1,Oakland\n10,13,108.1,Oakland\n11,26,107.1,Oakland\n12,9,106.1,Oakland\n13,1,105.1,Oakland\n22,17,104.1,Oakland\n1,2,103.1,Oakland\n28,24,102.1,Oakland\n18,14,11.1,SanJose\n6,25,10.1,Oakland\n19,15,9.1,SanJose\n3,19,8.1,SanJose\n3,11,7.1,Oakland\n27,12,6.1,Oakland\n1,3,5.1,Oakland\n25,4,4.1,SanJose\n5,6,3.1,SanJose\n29,22,2.1,SanJose\n30,23,1.1,SanJose"
    
    host_mngr = HostMngr.new(host_list)
    
    assert_equal({ host: 1, score: 28, cost: 300.1, city: 'SanFrancisco' }, host_mngr.first_host)
  end
  
  it 'must display all pages' do
    host_list = "1,28,300.1,SanFrancisco\n4,5,209.1,SanFrancisco\n20,7,208.1,SanFrancisco\n23,8,207.1,SanFrancisco\n16,10,206.1,Oakland\n1,16,205.1,SanFrancisco\n6,29,204.1,SanFrancisco\n7,20,203.1,SanFrancisco\n8,21,202.1,SanFrancisco\n2,18,201.1,SanFrancisco\n2,30,200.1,SanFrancisco\n15,27,109.1,Oakland\n10,13,108.1,Oakland\n11,26,107.1,Oakland\n12,9,106.1,Oakland\n13,1,105.1,Oakland\n22,17,104.1,Oakland\n1,2,103.1,Oakland\n28,24,102.1,Oakland\n18,14,11.1,SanJose\n6,25,10.1,Oakland\n19,15,9.1,SanJose\n3,19,8.1,SanJose\n3,11,7.1,Oakland\n27,12,6.1,Oakland\n1,3,5.1,Oakland\n25,4,4.1,SanJose\n5,6,3.1,SanJose\n29,22,2.1,SanJose\n30,23,1.1,SanJose"
    
    host_mngr = HostMngr.new(host_list)  
    
    pages = host_mngr.paginate
    
    puts 'pages'
    puts pages.count

    pages[0].must_equal([
      { :host => 1, :score => 28, :cost => 300.1, :city => 'SanFrancisco' },
      { :host=>2, :score=>30, :cost=>200.1, :city=>"SanFrancisco" },
      { :host=>3, :score=>19, :cost=>8.1, :city=>"SanJose"},
      { :host=>4, :score=>5, :cost=>209.1, :city=>"SanFrancisco"},
      { :host=>5, :score=>6, :cost=>3.1, :city=>"SanJose"},
      { :host=>6, :score=>29, :cost=>204.1, :city=>"SanFrancisco"},
      { :host=>7, :score=>20, :cost=>203.1, :city=>"SanFrancisco"},
      { :host=>8, :score=>21, :cost=>202.1, :city=>"SanFrancisco"},
      { :host=>10, :score=>13, :cost=>108.1, :city=>"Oakland"},
      { :host=>11, :score=>26, :cost=>107.1, :city=>"Oakland"},
      { :host=>12, :score=>9, :cost=>106.1, :city=>"Oakland" },
      { :host=>13, :score=>1, :cost=>105.1, :city=>"Oakland"},
    ])

    pages[1].must_equal([])
  end
end
