#ifndef _BINARY_UTILS_H_
#define _BINARY_UTILS_H_

#include <stdbool.h>
#include "jni.h"

void* CURR_GL_CONTEXT;

JavaVM* runtimeJavaVMPtr;
JNIEnv* runtimeJNIEnvPtr_ANDROID;
JNIEnv* runtimeJNIEnvPtr_JRE;

JavaVM* dalvikJavaVMPtr;
JNIEnv* dalvikJNIEnvPtr_ANDROID;
JNIEnv* dalvikJNIEnvPtr_JRE;

long showingWindow;

bool isInputReady, isCursorEntered, isPrepareGrabPos, isUseStackQueueCall;

int savedWidth, savedHeight;

jboolean attachThread(bool isAndroid, JNIEnv** secondJNIEnvPtr);
char** convert_to_char_array(JNIEnv *env, jobjectArray jstringArray);
jobjectArray convert_from_char_array(JNIEnv *env, char **charArray, int num_rows);
void free_char_array(JNIEnv *env, jobjectArray jstringArray, const char **charArray);

void closeGLFWWindow();

#endif // _BINARY_UTILS_H_

