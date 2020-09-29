# Input is a number of meetings (start_time, end_time)。 Output is a number of time intervals (start_time, end_time), where there is no meetings.

# For exmaple, input is [[[1, 3], [6, 7]], [[2, 4]], [[2, 3], [9, 12]]]

# output [[4, 6], [7, 9]]

# scheduled:
# inputs:[
# [
#   [1, 3], -----> 1, 2
#   [6, 7], -----> 6
# ],
# [
#   [2, 4] -----> 2, 3
# ]
# [
#   [2, 3], -----> 2
#   [9, 12] -----> 9, 10, 11
# ]
#]

# timeline 1-2-3-4...6-7...9-10-11-12

# output
# [
#   [4, 6],
#   [7, 9]
# ]

require "minitest/autorun"

class MeetingTime

  def scheduled_time(meetings_input)
    meetings = meetings_input.flatten(1)
    ocupy_hours = retrieve_ocupy_hours(meetings)
    free_hours = (1..11).to_a - ocupy_hours

    parse_schedule(free_hours)
  end

  def retrieve_ocupy_hours(meetings)
    meetings.each_with_object([]) do |meeting, array|
      array << (meeting[0]...meeting[1]).to_a
    end.flatten.uniq
  end

  def parse_schedule(free_hours, first_elm=nil)
    free_hours.each_with_object([]) do |hour, array|
      first_elm = hour unless first_elm
      unless free_hours.include?(hour + 1)
        array << [first_elm, hour + 1]
        first_elm = nil
      end
    end
  end
end

class MeetingTimeTest < Minitest::Test
  describe '#scheduled_time' do
    before do
      @meeting = MeetingTime.new
    end

    it 'receive any times and returns an schedule case 1' do
      input_meetings = [
        [[1, 3], [6, 7]],
        [[2, 4]],
        [[2, 3], [9, 12]]
      ]

      scheduled = @meeting.scheduled_time(input_meetings)

      assert_equal [[4, 6], [7, 9]], scheduled
    end

    it 'receive any times and returns an schedule case 2' do
      input_meetings = [
        [[2, 4]]
      ]

      scheduled = @meeting.scheduled_time(input_meetings)

      assert_equal [[1, 2], [4, 12]], scheduled 
    end
  end
end
