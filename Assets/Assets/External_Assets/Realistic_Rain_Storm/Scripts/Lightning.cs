using UnityEngine;
using System.Collections;

public class Lightning : MonoBehaviour {
	
public float offMin= 10; // Minimum wait time between each lightning/thunder
public float offMax= 60; // Maximum wait time between each lightning/thunder

public AudioSource ThunderAudioA;
public AudioSource ThunderAudioB;
public AudioSource ThunderAudioC;
public AudioSource ThunderAudioD;
public GameObject LightningBolt;

private float onMin= 0.25f; // Minimum duration of lightning bolt flash
private float onMax= 2; // Maximum duration of lightning bolt flash
private int ThunderRND = 1;
private float ThunderVol;
private float ThunderWait;

// private int ThunderRND = 1;


void Start ()
{

	 StartCoroutine("Storm");

}
 

IEnumerator  Storm (){
  
     while(true)
			
         {
         yield return new WaitForSeconds(Random.Range(offMin, offMax)); // Random delay before next lighning, between OffMin and Offmax

         LightningBolt.SetActive (true); // Show the lighning bolt particle effect 

         LightningBolt.transform.Rotate(0,(Random.Range(1, 360)),0); // Random direction of lighing bolt
         
	     // soundfx(); // Play thunder sound
		 StartCoroutine("Soundfx");

         yield return new WaitForSeconds(Random.Range(onMin, onMax)); // Random duration of lightning flash
  
         LightningBolt.SetActive (false); // Hide the lighning bolt particle effect
         }

 }
 

IEnumerator Soundfx (){

     // Choose a random thunder sound effect with random rolume

     ThunderRND = (Random.Range(1,5));
     ThunderVol = (Random.Range(0.2f,1.0f)); // Random thunder volume
     ThunderWait = ((9 - ((ThunderVol * 3)*3))-2); // The lower the thunder volulme the longer wait between lighting flash and thunder sound
     
   	while (ThunderRND == 1){
     yield return new WaitForSeconds(ThunderWait);
     ThunderAudioA.volume = ThunderVol;
     ThunderAudioA.Play();
     
     ThunderRND = 0;
     }     
 
   	while (ThunderRND == 2){
     yield return new WaitForSeconds(ThunderWait);
     ThunderAudioB.volume = ThunderVol;
     ThunderAudioB.Play();
     ThunderRND = 0;
     }
     
     while (ThunderRND == 3){
     yield return new WaitForSeconds(ThunderWait);
     ThunderAudioC.volume = ThunderVol;
     ThunderAudioC.Play();
     ThunderRND = 0;
     }
     while (ThunderRND == 4){
     yield return new WaitForSeconds(ThunderWait);
     ThunderAudioD.volume = ThunderVol;
     ThunderAudioD.Play();
     ThunderRND = 0;
     }

      
     
 }
}