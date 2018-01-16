
// helpers
const should = require('chai')
    .use(require('chai-as-promised'))
    .should()
const expect = require('chai').expect


// --- Handled contracts
const Doppler = artifacts.require("./Doppler.sol")

let doppler = null

let protocolOwner = null
let anyUser = null


contract('Doppler', async accounts => {

    before( async () => {
        protocolOwner = accounts[0]
        anyUser = accounts[1]
        doppler = await Doppler.new({ from: protocolOwner })
    })

    context('Songs', () => {

        it("should add a new song", async () => {
            const {logs} = await doppler.addSong(
                'teste',
                'teste',
                {from: anyUser}
            )
            const event = logs.find(e => e.event === 'Songs')
            const args = event.args
            expect(args).to.include.all.keys([
                'owner',
                'songName',
                'content'
            ])
            assert.equal(args.owner, anyUser, "The user must be the song's owner")
        })

        it("should return user's songs", async () => {
            const returnOf = await doppler.getMySongs(
                {from: anyUser}
            )
            console.log(returnOf)
        })

    })

    context('Playlists', () => {

        it("should add a new song", async () => {
            await doppler.addSong(
                "test2",
                "test2",
                {from: anyUser}
            )
        })

        it("should add a new playlist", async () => {
            const {logs} = await doppler.addPlaylist(
                "teste",
                [0,1],
                {from: anyUser}
            )
            const event = logs.find(e => e.event === 'Playlists')
            const args = event.args
            expect(args).to.include.all.keys([
                'owner',
                'playlistName',
                'indexes'
            ])
            assert.equal(args.owner, anyUser, "The user must be the playlist's owner")
        })

    })

})

