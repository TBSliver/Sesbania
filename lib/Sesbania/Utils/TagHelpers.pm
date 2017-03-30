package Sesbania::Utils::TagHelpers;

use Mojo::DOM::HTML;
use Mojo::ByteStream;
use Exporter 'import';

@EXPORT_OK = qw/ _tag _root _text _render_byte_tree /;
%EXPORT_TAGS = (all => \@EXPORT_OK);

=head2

Node array:

  0. Node Type
  1. Tag Name (if tag), Raw Content (if raw), Names
  2. attributes (id, class etc.
  3. Namespace (for xml stuff)
  4. Child array

=cut

=head2 _root

This takes an array of nodes and returns a root node array

=cut

sub _root {  return ['root', @_] }

=head2 _text

This takes a text block to render inside a tag

=cut

sub _text { return ['text', @_] }

=head2 _tag

This takes a tag name, attributes and an arrayref of children nodes.

=cut

sub _tag {  return ['tag', shift, shift, undef, shift] }

sub _render_byte_tree {
  return _render_bytestream(_render_tree(shift));
}

sub _render_tree {
  return Mojo::DOM::HTML::_render(shift);
}

sub _render_bytestream {
  return Mojo::ByteStream->new(shift);
}
