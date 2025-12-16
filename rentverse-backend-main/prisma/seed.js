const { PrismaClient } = require('@prisma/client')
const { v4: uuidv4 } = require('uuid')

const prisma = new PrismaClient()

async function main() {
  console.log('🌱 Seeding property types with UUIDs...')

  const propertyTypesData = [
    { name: 'Apartment', code: 'APARTMENT' },
    { name: 'House', code: 'HOUSE' },
    { name: 'Penthouse', code: 'PENTHOUSE' },
    { name: 'Studio', code: 'STUDIO' },
    { name: 'Condo', code: 'CONDO' },
    { name: 'Townhouse', code: 'TOWNHOUSE' },
    { name: 'Villa', code: 'VILLA' },
  ]

  for (const pt of propertyTypesData) {
    const id = uuidv4()
    await prisma.propertyType.upsert({
      where: { code: pt.code }, // skipDuplicates replacement
      update: {}, // nothing to update
      create: { id, ...pt },
    })
    console.log(`✅ Created property type: ${pt.name} with ID: ${id}`)
  }

  console.log('✅ All property types seeded')
}

main()
  .catch((err) => {
    console.error(err)
    process.exit(1)
  })
  .finally(async () => {
    await prisma.$disconnect()
  })