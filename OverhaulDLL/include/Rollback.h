#pragma once
#ifndef ROLLBACK_H
#define ROLLBACK_H

#include <stdint.h>
#include <unordered_map>

#include "DarkSoulsOverhaulMod.h"

#include "PlayerInsStructFunctions.h"
#include "PadManStructFunctions.h"
#include "BulletManStructFunctions.h"
#include "SfxManStructFunctions.h"

#include "NetcodePackets.h"

class Rollback
{
public:
    static void start();

    static void GameStateSave();
    static void GameStateLoad();

    static void GameInputSave();
    static void GameInputLoad();

    static void NetcodeFix();

    static void LoadRemotePlayerPacket(MainPacket* pkt, PlayerIns* player);

    static bool gsave;
    static bool gload;
    static bool isave;
    static bool iload;

    static bool rollbackEnabled;

    static const uint32_t RollbackSinglePacketType = 2; //this is unused, and passes the checks the game does on the type
private:

    static PlayerIns* saved_playerins;
    static PadMan* saved_padman;
    static BulletMan* saved_bulletman;
    static SfxMan* saved_sfxman;

    static const uint64_t sendNetMessage_offset = 0x5096d0;
    static const uint64_t getNetMessage_offset = 0x509560;
    static const uint64_t send_generalplayerinfo_offset = 0x3980e0;
    static const uint64_t Read_GeneralPlayerData_offset = 0x395de0;
    static const uint64_t disableType18PacketEnforcement = 0x35b13b;

};

inline void* malloc_(size_t size)
{
    void* out = malloc(size);
    if (out == NULL)
    {
        FATALERROR("Malloc failure. Unable to allocate %d bytes.", size);
    }
    memset(out, 0, size);
    return out;
}

#endif
