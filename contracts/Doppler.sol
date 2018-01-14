pragma solidity ^0.4.18;

contract Doppler {
  
  address public owner;

  mapping(address => Song[]) songs;
  mapping(address=> mapping(bytes => Song[])) playlists;

  event Songs(address indexed owner, bytes songName, bytes content);
  event Playlists(address indexed owner, bytes playlistName, uint[] indexes);
  
  struct Song {
    bytes songName;
    bytes content;
  }

  function Dopler() {
    owner = msg.sender;
  }

  function addSong(bytes songName, bytes contentHash) public {
    Song memory song = Song(songName,contentHash);
    song.songName = songName;
    song.content = contentHash;
    Song[] storage userSongs = songs[msg.sender];
    userSongs.push(song);
    songs[msg.sender] = userSongs;
    Songs(msg.sender,songName,contentHash);
  }

  function addPlaylist(bytes playlistName, uint[] songIndexes)
    public
    returns(bool)
  {
    Song[] memory userSongs = songs[msg.sender];
    for (uint i = 0; i < songIndexes.length; i++) {
        Song memory playlistSong = userSongs[songIndexes[i]];
        playlists[msg.sender][playlistName].push(playlistSong);
    }
    Playlists(msg.sender, playlistName, songIndexes);
  }

}