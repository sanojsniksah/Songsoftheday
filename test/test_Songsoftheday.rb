require 'helper'

class TestSongsoftheday < Test::Unit::TestCase
    def setup
      @songs = Songsoftheday.new 
    end

  def test_theyear2000called
    assert_equal "And they want free content", @songs.theyear2000called
  end
  
  def test_howmany
    assert_equal 489, @songs.howmany
  end
  
  def test_thanks
    assert_equal "kexp", @songs.thanks
  end

end
