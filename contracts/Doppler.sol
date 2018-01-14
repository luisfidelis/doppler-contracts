pragma solidity ^0.4.18;

contract Doppler {
  
  address public owner;
  mapping(address=>mapping(bytes => bytes)) songs;
  mapping(address=>mapping(bytes => mapping(uint => bytes))) playlists;

  function Dopler() {
    owner = msg.sender;
  }

  function addSong(bytes songName, bytes contentHash) public {
    songs[msg.sender][songName] = contentHash;
  }

  function addPlaylist(bytes playlistName, bytes[] songNames) public {
    for (uint i = 0; i < songNames.length; i++) {
        playlists[msg.sender][playlistName][i] = songNames[i];
    }
  }

}