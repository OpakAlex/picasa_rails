# -*- encoding : utf-8 -*-
require "spec_helper"

describe Utils::Picasa do

  before :all do
    user_id = "108526789293644615908"
    Utils::Picasa::Api.new(user_id: user_id)
    @album = Utils::Picasa::Api.get_albums![1]
    @album.load_photos
    @photo = @album.photos.first

    @comment = <<-"EOF"
        <entry xmlns="http://www.w3.org/2005/Atom">
        <content>New Comment</content>
        <category scheme="http://schemas.google.com/g/2005#kind" term="http://schemas.google.com/photos/2007#comment"/>
        </entry>
    EOF

  end

  it{ @album.title.should eq "beer" }
  it{ @album.summary.should eq "" }
  it{ @album.id.should eq "5860403384898328401" }
  it{ @album.author.should eq "Александр Опак" }
  it{ @album.updated.should eq "2013-03-28T14:58:48.874Z" }
  it{ @album.published.should eq "2012-07-31T18:04:02.000Z" }
  it{ @album.thumb.should eq "https://lh4.googleusercontent.com/-jPd8PBf_9Pc/UVRV1C1cl1E/AAAAAAAAAKg/LKarigUZsIY/s160-c/Beer.jpg" }

  it "should get 3 first photo" do
    @album.photos.size.should  <= 3
  end

  it "should get count comments for photo" do
    @photo.comments_count.should == 7
  end

  it "should don't create new comment without token" do
    comment = {photo_id: @photo.id, content: "New Comment"}
    comment = Utils::Picasa::Comment.create(@photo.album_id, comment)
    comment.should == false
  end

  it "should create valid xml for comment" do
    Utils::Picasa::Comment.send(:string_comment, "New Comment").should eq @comment
  end

end