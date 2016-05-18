package DDG::Goodie::KanjiStrokeorder;

# Takes Kanji (Chinese characters used in Japanese) and returns either an animated gif
# of or a sequence of svgs showing the correct way to write it.
#
# Eventually I'd like to expand this to Simplified/Traditional Hanzi (Chinese characters
# used in Chinese) as well, but I'm less knowledgable about them and distinguishing them
# from Kanji may prove difficult.

use strict;
use DDG::Goodie;
use utf8;
#with 'DDG::GoodieRole::ImageLoader';


zci answer_type => 'kanji_strokeorder';

# Caching - http://docs.duckduckhack.com/backend-reference/api-reference.html#caching`
zci is_cached => 1;#1; testing not caching so animation repeats

# Triggers - http://docs.duckduckhack.com/walkthroughs/calculation.html#triggers
triggers any => 'stroke order', 'strokeorder', 'kanji', 'chinese character';

# Handle statement
handle remainder => sub {

    my $remainder = $_;

    return unless $remainder;

    my @kanji = split " ", $remainder;
    my $count = scalar @kanji;
    my @list  = map { ord($_) }  @kanji;
    my $list_view = $count > 1;

    print "$list[0]\n$kanji[0]\n";





	my $image = "/svgs/$list[0]";
	#my $image_tag = goodie_img_tag({$image, 80});
	my $title_text = "Stroke order for $count kanji";

	my $image_prefix = "/share/goodie/kanji_strokeorder/svgs/";
	my $anim_suffix = "_animated.svg";
	my $frame_suffix = "_frames.svg";


	my $plaintext = "Kanji stroke order:";

	my @items;
	foreach my $i (0 .. $#kanji) {
		my %result = ( 
			kanji_name  => $kanji[$i], 
			image => scalar share("svgs/".ord($kanji[$i])."_animated.svg")->slurp,
			url => "https://en.wiktionary.org/wiki/".$kanji[$i], #add support for other languages later
			detail => {
				url => "https://en.wiktionary.org/wiki/".$kanji[$i], #add support for other languages later,
				image => scalar share("svgs/".ord($kanji[$i])."_frames.svg")->slurp
			}
		);

		push @items, \%result;

		$plaintext .= "\n$kanji[$i]: "
	};

	print $plaintext;
	print "\n\n@@\n\n";

	    return $plaintext, #no idea if this is true
		structured_answer => {
			id   => 'kanji_strokeorder',
	#		name => 'Answer',#'Stroke order', 
			data => \@items,
			meta => {
				sourceUrl => "https://wiktionary.org", #wiktionary
				soureName => "Wiktionary "			
			},
			templates => {
				group => 'base',
				detail => 'basic_info_detail',
				options => {
					content => 'DDH.kanji_strokeorder.content',
				}
			}
} ; };
1;
## get_kanji_frames($image); 


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
#};

#sub get_kanji_animated
#{
#    return share('svgs/'.ord("@_").'_animated.svg');
#}
#
#sub get_kanji_frames
##goodie_img_tag
#{
#print share('svgs/'.ord("@_").'_frames.svg');
#   return  share('svgs/'.ord("@_").'_frames.svg');
#
#}

1;
