-- Time-stamp: <19 oct 2012 15:00 queinnec@enseeiht.fr>

with Ada.Text_IO; use Ada.Text_IO;
with Ada.Exceptions;

-- Version avec conditions d'acceptation. Pas de priorité définie.
package body LR.Synchro.Basique2 is

   function Nom_Strategie return String is
   begin
      return "Basique, par conditions d'acceptation";
   end Nom_Strategie;

   task LectRedTask is
      entry Demander_Lecture;
      entry Demander_Ecriture;
      entry Terminer_Lecture;
      entry Terminer_Ecriture;
   end LectRedTask;

    task body LectRedTask is
        type EtatType is (Libre,Ecriture,Lecture);
        ecrivain : Boolean := False;
        nbLect : natural := 0;
    begin
        loop

            select
                when nbLect = 0 and not ecrivain => accept Demander_Ecriture;
                    ecrivain := True;

            or
                when  not ecrivain => accept Demander_Lecture;
                    nbLect := nbLect + 1;

            or
                accept Terminer_Ecriture;
                ecrivain := False;

            or
                accept Terminer_Lecture;
                nbLect := nbLect - 1;

end select;
      end loop;
   exception
      when Error: others =>
         Put_Line("**** LectRedTask: exception: " & Ada.Exceptions.Exception_Information(Error));
   end LectRedTask;

   procedure Demander_Lecture is
   begin
      LectRedTask.Demander_Lecture;
   end Demander_Lecture;

   procedure Demander_Ecriture is
   begin
      LectRedTask.Demander_Ecriture;
   end Demander_Ecriture;

   procedure Terminer_Lecture is
   begin
      LectRedTask.Terminer_Lecture;
   end Terminer_Lecture;

   procedure Terminer_Ecriture is
   begin
      LectRedTask.Terminer_Ecriture;
   end Terminer_Ecriture;

end LR.Synchro.Basique2;
