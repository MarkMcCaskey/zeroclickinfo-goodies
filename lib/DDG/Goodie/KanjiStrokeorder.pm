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
	my $image_tag = goodie_img_tag({$image, 80});
	my $title_text = "Stroke order for $count kanji";

	my $image_prefix = "/share/goodie/kanji_strokeorder/svgs/";
	my $anim_suffix = "_animated.svg";
	my $frame_suffix = "_frames.svg";

	my $i;
	my @items;
	foreach $i (0 .. ($count - 1)) {
        $items[$i] = { #map( {
		media_item => {
			title  => "$kanji[$i]",
			image       =>  $image_prefix . ord($kanji[$i]) . $anim_suffix,
			options => {
				altSubtitle => false,
				subtitle    => false,
				description => false,
				footer      => false,
				dateBadge   => false,
			image       => $image_prefix . ord($kanji[$i]) . $anim_suffix
			}
			},
		media_item_detail => {
			title => "$kanji[$i]",
			options => {
				altSubtitle => false,
				description => false,
				callout     => false,
			image => $image_prefix . ord($kanji[$i]) . $frame_suffix
#				image       => true
			},

			image => $image_prefix . ord($kanji[$i]) . $frame_suffix
			} # ,
	#	media_detail => {
#			url => "lel",
#			image => $image_prefix . ord($kanji[$i]) . $anim_suffix,
#			options => {
#				title => false,
#				subtitle => false,
#				content => false,
#				infoboxData => false,
#				image => true
#			},
#			description => 'wat'
#			} 
			}; #, @kanji) };
}

	    return "plain text response", #no idea if this is true
		structured_answer => {
			id   => 'kanji_strokeorder',
			name => 'Stroke order', 
			data => \@items,
			meta => {
				itemType => 'kanji stroke order diagrams',
				options => {
					sourceName => false,
					sourceUrl => false,
					searchTerm => false,
					itemType => true,
					primaryText => false,
					secondaryText => false,
					sourceLogo => false,
					sourceIcon => false,
					sourceIconUrl => false,
					snippetChars => false,
					pinIcon => false,
					pinIconSelected => false,
					minTopicsForMenu => false
				}
			},
			#view => 'tiles',
			templates => {
				item => 'media_item',
#				detail => 'media_detail', #might as well try everything
				item_detail => 'media_item_detail',
				options => {
				#	altSubtitle => false, subtitle => false, description => false, footer => false, dateBadge => false,	
					#callout => true,
				#	moreAt => true, aux => false,
					item => true,
					item_detail => true,
#
					
				}
			}

		
}
		};
#};
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
