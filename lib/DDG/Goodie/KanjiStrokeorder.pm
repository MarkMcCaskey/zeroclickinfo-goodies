package DDG::Goodie::KanjiStrokeorder;

# Takes Kanji (Chinese characters used in Japanese) and returns either an animated gif
# of or a sequence of svgs showing the correct way to write it.
#
# Eventually I'd like to expand this to Simplified/Traditional Hanzi (Chinese characters
# used in Chinese) as well, but I'm less knowledgable about them and distinguishing them
# from Kanji may prove difficult.

use utf8;
use DDG::Goodie;
use strict;
with 'DDG::GoodieRole::ImageLoader';

zci answer_type => 'kanji_strokeorder';

# Caching - http://docs.duckduckhack.com/backend-reference/api-reference.html#caching`
zci is_cached => 1;

# Triggers - http://docs.duckduckhack.com/walkthroughs/calculation.html#triggers
triggers any => 'stroke order', 'strokeorder','@@@!!!@@@';

# Handle statement
handle remainder => sub {

    my $remainder = $_;

    return unless $remainder;

    my @kanji = split " ", $remainder;
    my $count = scalar @kanji;
    my @list  = map { ord($_) }  @kanji;
    my $list_view = $count > 1;

    print "$list[0]\n$kanji[0]\n";


	my $image = "/share/goodie/kanji_strokeorder/svgs/$list[0]_animated.svg";
	my $image_tag = goodie_img_tag({$image, 80});
	my $title_text = "Stroke order for $count kanji";


	    return 
		heading => $title_text,
		answer  => $title_text,
	#	subtitle => $remainder,
		html    => "<div class='text--secondary'>Stroke order diagram for $kanji[0]</div>" . get_kanji_animated("/svgs/$list[0]") . get_kanji_frames("/svgs/$list[0]"); 


    # Optional - Guard against no remainder
    # I.E. the query is only 'triggerWord' or 'trigger phrase'
    #

    # Optional - Regular expression guard
    # Use this approach to ensure the remainder matches a pattern
    # I.E. it only contains letters, or numbers, or contains certain words
    #
    # return unless qr/^\w+|\d{5}$/;

    #return "plain text response",
        #structured_answer => {
#
#	    id => 'kanji_strokeorder',
#            name => 'Reference',
#            data => {
#              title => "Stroke order for $count kanji",
#              subtitle => "$remainder",
#              image => "/share/goodie/kanji_strokeorder/svgs/$list[0]_animated.svg",
#              list => \@list,
#              list_view => $list_view
#            },
#
#	    return 
#		heading => title
#		answer  => title
#		html    => "<div class='text--secondary'>Stroke order diagram for $kanji[0]</div>" . goodie_img_tag(image,width=>80); 
#
#            #templates => {
#                #group => "list",
                #options => {
                #    list_content = "DDH.kanji_strokeorder.list_content"
                #}
            #}
  #      };
};

#Thanks, GuitarChords.pm!
sub get_kanji_animated
{
    goodie_img_tag({filename=>$_[0].'_animated.svg', width=>78});
}

sub get_kanji_frames
{
    goodie_img_tag({filename=>$_[0].'_frames.svg'});

}


1;
