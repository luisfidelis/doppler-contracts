pragma solidity ^0.4.18;

contract Doppler {
  
  address public owner;

  mapping(address => User) profiles;

  event Songs(address indexed owner, bytes songName, bytes content);
  event Playlists(address indexed owner, bytes playlistName, uint[] indexes);
  event UserCreated(address indexed owner, string nickname);
  
  struct User {
    string nickname;
    Song[] songs;
    Playlist[] playlists;
    uint active;
  }

  struct Song {
    bytes songName;
    bytes content;
  }

  struct Playlist {
    bytes playlistName;
    Song[] songs;
  }

  modifier newUser() {
    require(!activeUser());
    _;
  }

  function Dopler() {
    owner = msg.sender;
  }

  function createUser(string _nickname)
    newUser
    public
    returns(bool)
  {
    User user = User(_nickname,[],1);
    profiles[msg.sender] = user;
    UserCreated(msg.sender, _nickname);
    return true;
  }

  function addSong(bytes songName, bytes contentHash) 
    public
  {
    require(activeUser());
    Song memory song = Song(songName,contentHash);
    profiles[msg.sender].songs.push(song);
    Songs(msg.sender,songName,contentHash);
  }

  function addPlaylist(bytes playlistName, uint[] songIndexes)
    public
    returns(bool)
  {
    require(activeUser());
    Song[] memory userSongs = profiles[msg.sender].songs;
    Song[] memory playlistSongs;
    for (uint i = 0; i < songIndexes.length; i++) {
        Song memory playlistSong = userSongs[songIndexes[i]];
        playlistSongs.push(playlistSong);
    }
    Playlist playlist = Playlist(playlistName, playlistSongs);
    profiles[msg.sender].playlists.push(playlist);
    Playlists(msg.sender, playlistName, songIndexes);
  }

  function activeUser() 
    view
    returns(bool)
  {
    return profiles[msg.sender].active == 1;
  }

}