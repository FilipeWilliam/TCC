/*
  Warnings:

  - Added the required column `institutionId` to the `Subjects` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "Subjects" ADD COLUMN     "institutionId" INTEGER NOT NULL;

-- AddForeignKey
ALTER TABLE "Subjects" ADD CONSTRAINT "Subjects_institutionId_fkey" FOREIGN KEY ("institutionId") REFERENCES "Institutions"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
